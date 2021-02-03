#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro


## ##################################################
## set config
cd $(dirname $0)
source ./config.sh

## ##################################################
## create directories
test -d ./data || mkdir ./data

## ##################################################
## add random wait time (many students => INTERNAL SERVER ERROR)
test "$1" = "-r" || sleep $((RANDOM % 60))

## get data
curl -SLG "${my_openaq_rest_api_url}/cities" -d "limit=9999" > data/api_cities.json
curl -SLG "${my_openaq_rest_api_url}/latest" -d "limit=7000" > data/api_latest.json

if grep "Internal Server Error" data/api_latest.json; then
    echo "ERROR on data/api_latest.json" >&2
    exit 1
fi

ls -l  data/api_*.json
