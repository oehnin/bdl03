#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

cd $(dirname $0)
source ./config.sh

hive_cli -f drop.sql

# hdfs dfs -ls -R /user/${USER}/demo/etl/
# hdfs dfs -rm -r /user/${USER}/demo/etl/openaq_org_api
hdfs dfs -rm    /user/${USER}/load/cities.json
hdfs dfs -rm    /user/${USER}/load/latest.*.json

hdfs dfs -ls -R /user/${USER}/load/

hive_cli <<EOSQL
  SHOW DATABASES;
EOSQL
