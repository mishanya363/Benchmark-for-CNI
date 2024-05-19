FROM alpine:3.19
RUN apk add --update sysstat && rm -rf /var/cache/apk/* && mkdir /data
COPY *.sh /
CMD ["sh","/monit.sh"]
