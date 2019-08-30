#!/usr/bin/env bash

# Only run PHP with XDebug if APP_DEBUG is enabled

if [ "${APP_DEBUG}" == true ] ; then
    export RESOLVED_PHP_IMAGE=${PHP_DEBUG_IMAGE}
else
    export RESOLVED_PHP_IMAGE=${PHP_IMAGE}
fi
