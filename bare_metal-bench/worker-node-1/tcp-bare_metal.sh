#!/bin/bash
#Перед запуском настройте доступ по ssh и создайте файл .hushlogin на удаленной машине
#и установите следующие пакеты: iperf3 sysstat

#Переменные по умолчанию
num=1
file="results-tcp"
#Служебные функции
function now { date +%s; }
trap ctrl_c INT
function ctrl_c {
        echo "Обнаружено CTRL-C, окончание скрипта ..."
        exit 1
}
#Опции
while [ "$1" != "" ]
do
        arg=$1
        case $arg in
                --numbers|-n)
                        shift
                        [ "$1" = "" ] && { echo "После параметра $arg должно идти значение"; exit 1; }
                        num=$1
                        echo "Будет проведено тестов: $num"
                        ;;
                *)
                        shift
                        echo "Неизвестный параметр $1"
                        ;;
        esac
        shift
done
#Проверка наличия файла
if [ -e $file ]; then
	rm $file
        touch $file
else
	touch $file
fi
ssh -qT worker-node-2 <<-EOF
if [ -e $file ]; then
        rm $file
        touch $file
else
        touch $file
fi
EOF
#Проведение бенчмарка
for i in $(seq 1 $num)
do	
	echo "Запуска теста $i"
	#Запускаем сервер с опцией на одно измерение
	iperf3 -s -1 > /dev/null &
	#Создаем временные папки
	workfile=$(mktemp)
	bwfile=$(mktemp)
	#Запускаем "мониторы" и запоминаем их PID
	nohup ./monit.sh > $workfile 2>/dev/null &
	mpid=$!
	rmpid=$(ssh -qT worker-node-2 <<-EOF
	touch ${workfile}
	nohup ./monit.sh > ${workfile} 2>/dev/null &
	echo \$!
	EOF
	)
	#Обозначаем время запуска и окончания
	STARTTIME=$(now)
        ENDTIME=$(( $STARTTIME + 10 ))
	#Запускаем измерение
	ssh -qT worker-node-2 "nohup ./iperf.sh tcp &" > $bwfile
	#Записываем результаты в файл
	nohup ./stats.sh $STARTTIME $ENDTIME $workfile $file $bwfile 2>/dev/null &
	ssh -qT worker-node-2 "nohup ./stats.sh $STARTTIME $ENDTIME $workfile $file 2>/dev/null &"
	#"Убиваем" "мониторы" и удаляем временные папки
	kill $mpid
	ssh -qT worker-node-2 <<-EOF
	kill $rmpid
	rm $workfile
	EOF
	rm $workfile
	echo "Тест $i окончен"
done
echo "Все тесты окончены"
