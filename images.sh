#!/usr/bin/env bash

export NC_REPO=alpine
export NC_TAG=3.8

export SED_REPO=alpine
export SED_TAG=3.8

export MYSQL_HOST=registry.hub.docker.com
export MYSQL_ACCOUNT=library
export MYSQL_REPO=mysql
export MYSQL_TAG=5.6.42
export MYSQL_IMAGE=${MYSQL_HOST}/${MYSQL_ACCOUNT}/${MYSQL_REPO}:${MYSQL_TAG}

export REDIS_HOST=registry.hub.docker.com
export REDIS_ACCOUNT=library
export REDIS_REPO=redis
export REDIS_TAG=5.0.3
export REDIS_IMAGE=${REDIS_HOST}/${REDIS_ACCOUNT}/${REDIS_REPO}:${REDIS_TAG}

export PHP_CS_FIXER_HOST=registry.hub.docker.com
export PHP_CS_FIXER_ACCOUNT=herloct
export PHP_CS_FIXER_REPO=php-cs-fixer
export PHP_CS_FIXER_TAG=2.13.0
export PHP_CS_FIXER_IMAGE=${PHP_CS_FIXER_HOST}/${PHP_CS_FIXER_ACCOUNT}/${PHP_CS_FIXER_REPO}:${PHP_CS_FIXER_TAG}

export PRETTIER_ESLINT_FIXER_HOST=registry.hub.docker.com
export PRETTIER_ESLINT_ACCOUNT=medology
export PRETTIER_ESLINT_REPO=prettier-eslint
export PRETTIER_ESLINT_TAG=2019-07-29
export PRETTIER_ESLINT_IMAGE=${PRETTIER_ESLINT_FIXER_HOST}/${PRETTIER_ESLINT_ACCOUNT}/${PRETTIER_ESLINT_REPO}:${PRETTIER_ESLINT_TAG}

export SELENIUM_HOST=registry.hub.docker.com
export SELENIUM_ACCOUNT=selenium
export SELENIUM_REPO=standalone-chrome-debug
export SELENIUM_TAG=3.14.0-dubnium
export SELENIUM_IMAGE=${SELENIUM_HOST}/${SELENIUM_ACCOUNT}/${SELENIUM_REPO}:${SELENIUM_TAG}

export WGET_HOST=registry.hub.docker.com
export WGET_OWNER=library
export WGET_REPO=alpine
export WGET_TAG=3.8
export WGET_IMAGE=${WGET_HOST}/${WGET_OWNER}/${WGET_REPO}:${WGET_TAG}

export S3_HOST=registry.hub.docker.com
export S3_ACCOUNT=minio
export S3_REPO=minio
export S3_TAG=latest
export S3_IMAGE=${S3_HOST}/${S3_ACCOUNT}/${S3_REPO}:${S3_TAG}
