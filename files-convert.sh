#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

## ##################################################
## set config
cd $(dirname $0)
source ./config.sh


## ##################################################
## reformat
cat data/api_cities.json | jq -c ' .results | . []' > data/cities.json
cat data/api_latest.json | jq    ' .results | . []' > data/latest.json

if [ ! -s data/cities.json -o ! -s data/latest.json ]; then
    ls -l data/cities.json data/latest.json
    echo "empty files => exit" >&2
    exit 1
fi

## ##################################################
## convert latest

cat data/latest.json | jq -c '
{
  location:        .location
, city:            .city
, country:         .country
, distance:        .distance
, coordinates:     .coordinates
}
' | sort -u > data/latest.location.json

cat data/latest.json | jq -c '
{
  location:        .location
, measurements:    .measurements[]
}
' | sort -u > data/latest.measurements.json

ls -l  data/latest*.json
