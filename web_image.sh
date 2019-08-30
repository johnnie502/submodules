#!/usr/bin/env bash

# Only run Web with XDebug if APP_DEBUG is enabled
if [ "${APP_DEBUG}" == true ] ; then
    export RESOLVED_WEB_IMAGE=${WEB_DEBUG_IMAGE}
else
    export RESOLVED_WEB_IMAGE=${WEB_IMAGE}
fi
