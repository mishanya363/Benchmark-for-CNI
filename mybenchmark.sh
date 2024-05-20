#!/bin/bash
#Основные переменные
num=1
file="unknown"
verbose="false"
#Создание папки
if [ ! -d "results" ]; then
	mkdir "results"
fi
res=results/$file.csv

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
		--file|-f)
			shift
			[ "$1" = "" ] && { echo "После параметра $arg должно идти значение"; exit 1; }
			file="$1"
			res=results/$file.csv
			if [ -e $res ]; then
				rm $res
				touch $res
			else
				touch $res
			fi
			echo "Данные будут записаны в файл $res"
                        ;;
		--verbose|-v)
			shift
			verbose="true"
			echo "Дополнительная информация будет выведена в терминал"
			;;
		*)
			shift
			echo "Неизвестный параметр $1"
			;;
	esac
	shift
done

if [ "$verbose" = "true" ]; then
	for run in $(seq 1 $num)
	do
		echo "|||||||||||Запуск теста $run|||||||||||"
		./myknb -f $res
		check=$?
		[ $check -ne 0 ] && { echo "Не получилось провести тест, ошибка $check, окончание скрипта ...";  exit 1; }
		printf "|||||||||||Тест $run окончен|||||||||||"
		printf " \n"
	done
else
	for run in $(seq 1 $num)
        do
		echo "|||||||||||Запуск теста $run|||||||||||"
                ./myknb -f $res > /dev/null
		check=$?
                [ $check -ne 0 ] && { echo "Не получилось провести тест, ошибка $check, окончание скрипта ..."; exit 1; }
		printf "|||||||||||Тест $run окончен|||||||||||"
		printf " \n"
        done
fi
