#!/usr/bin/env bash

## ##################################################
## set config
#cd $(dirname $0)
#source ./config.sh

## ##################################################
## create directories
## test -d ./flights_2 || mkdir ./data

## ##################################################
## create hdfs directories
hdfs dfs -test -f flights_2 || hdfs dfs -mkdir -p /user/${USER}/flights_2



#hdfs dfs -test -f flights/flights.csv || hdfs dfs -put flights.csv /user/bd01/flights/
#hdfs dfs -test -f flights/airports.csv || hdfs dfs -put airports.csv /user/bd01/flights/
#hdfs dfs -test -f flights/airlines.csv || hdfs dfs -put airlines.csv /user/bd01/flights/
#echo "----------------"

## ##################################################
## ddl
#hive_cli -f create.sql
