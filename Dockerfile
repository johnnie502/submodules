FROM chekote/node:10.16.2-alpine

# node-sass requirements
RUN set -eux; \
    \
    apk add --no-cache \
        g++ \
        make \
        python \
    ;
