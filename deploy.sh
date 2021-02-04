#!/usr/bin/env bash

## ##################################################
## create hdfs directories
hdfs dfs -test -f flights_2 || hdfs dfs -mkdir -p /user/${USER}/flights_2


## ##################################################
## ddl
hive_cli -f create.sql
