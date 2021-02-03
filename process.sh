#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

## ##################################################
## set config
cd $(dirname $0)
source ./config.sh

## ##################################################
## fetch
./files-fetch.sh

## ##################################################
## convert latest
./files-convert.sh

## ##################################################
## push files to hdfs
./files-push2hdfs.sh

## ##################################################
## load data
hive_cli -f load.sql
