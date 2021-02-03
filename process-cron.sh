#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

## ##################################################
## set config
cd $(dirname $0)

## ##################################################
## create directories
test -d ./log || mkdir ./log

## ##################################################
## process with logging
./process.sh > log/$(basename $0 .sh).$(date +%Y%m%d_%H%M%S).log 2> log/$(basename $0 .sh).$(date +%Y%m%d_%H%M%S).err

