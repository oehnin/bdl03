#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

## ##################################################
## set config
cd $(dirname $0)
source ./config.sh

## ##################################################
## push files to hdfs
hdfs dfs -ls /user/${USER}/load/
hdfs dfs -put -f data/cities.json               /user/${USER}/load/
hdfs dfs -put -f data/latest.location.json      /user/${USER}/load/
hdfs dfs -put -f data/latest.measurements.json  /user/${USER}/load/
hdfs dfs -ls /user/${USER}/load/
