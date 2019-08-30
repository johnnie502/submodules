ARG PHP_IMAGE
FROM ${PHP_IMAGE}

COPY xdebug.conf /tmp

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests php${PHP_VERSION}-xdebug && \
    #
    # Configure XDebug
    cat /tmp/xdebug.conf >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini && \
    rm /tmp/xdebug.conf && \
    #
    # Cleanup
    apt-get remove -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
