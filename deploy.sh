#!/usr/bin/env bash

## ##################################################
## set config
cd $(dirname $0)
source ./config.sh


## ##################################################
## create hdfs directories
hdfs dfs -test -f flights_2 || hdfs dfs -mkdir -p /user/${USER}/flights_2


## ##################################################
## ddl
hive_cli -f create.sql
