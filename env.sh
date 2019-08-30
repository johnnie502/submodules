#!/usr/bin/env bash

ENV='';
if [ "${CI}" == true ] ; then
    ENV+=" --env CI"
fi
