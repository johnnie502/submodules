FROM chekote/php:7.1.30-laravel5.3

ADD wkhtmltox_0.12.5-0.20180526.136.dev_42ee518_bionic_amd64.deb /root/wkhtmltox.deb
ADD imagick-policy.xml /root/policy.xml

ENV PHP_ALL_MAX_EXECUTION_TIME 60
ENV PHP_FPM_PM__MAX_CHILDREN 50
ENV PHP_FPM_PM__MAX_SPARE_SERVERS 15
ENV PHP_FPM_PM__START_SERVERS 10

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    #
    # wkhtmltopdf requirements
    ghostscript \
    #
    # keen.io requirements
    php${PHP_VERSION}-mcrypt \
    #
    # stdcheck requirements
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-gmp \
    php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-bcmath \
    tesseract-ocr \
    #
    # phpunit requirements
    php${PHP_VERSION}-dom \
    #
    # webdriver requirements
    php${PHP_VERSION}-curl && \
    #
    # wkhtmltopdf (cannot install from Ubuntu repo's because we need patched qt)
    apt install -y /root/wkhtmltox.deb && \
    rm /root/wkhtmltox.deb && \
    #
    # Cleanup
    apt-get remove -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    #
    # Allow imagemagick to process PDFs again
    cp /root/policy.xml /etc/ImageMagick-6/policy.xml && \
    rm /root/policy.xml && \
    #
    # Blackfire Probe
    curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") && \
    mkdir -p /tmp/blackfire && \
    tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire && \
    mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so && \
    printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > /etc/php/${PHP_VERSION}/fpm/conf.d/blackfire.ini && \
    rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz
