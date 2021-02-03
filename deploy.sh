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
## create hdfs directories
# hdfs dfs -mkdir -p /user/${USER}/demo/etl/openaq_org_api/
hdfs dfs -mkdir -p /user/${USER}/load

## ##################################################
## ddl
hive_cli -f create.sql
