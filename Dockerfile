FROM phpmyadmin/phpmyadmin:4.6.4-1

RUN apk update
RUN apk add tzdata
