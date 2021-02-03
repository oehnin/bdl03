#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

export my_openaq_rest_api_url=https://api.openaq.org/v1

function hive_cli {
  if [ -n "${JDBC_HIVE2_URL}" ]; then
    beeline -n "${USER}" -u "${JDBC_HIVE2_URL}" "$@"
  else
    hive "$@"
  fi
}

set -xv
