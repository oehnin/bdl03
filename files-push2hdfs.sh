#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

## ##################################################
## set config
cd $(dirname $0)
source ./config.sh

## ##################################################
## push files to hdfs
hdfs dfs -ls /user/${USER}/flights_2/
hdfs dfs -put -f flights.csv    /user/${USER}/flights_2/
hdfs dfs -put -f airports.csv   /user/${USER}/flights_2/
hdfs dfs -put -f airlines.csv  	/user/${USER}/flights_2/
hdfs dfs -ls /user/${USER}/flights_2/
