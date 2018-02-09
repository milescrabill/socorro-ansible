#!/bin/bash
set -u

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 environment"
    exit 1
fi

REPOSITORY="socorro-es-migration-${1}"
BACKUP=$(date +%s)

echo "Requesting full backup $BACKUP in $REPOSITORY"
curl -XPUT "http://localhost:9200/_snapshot/${REPOSITORY}/${BACKUP}"

echo -e "\nCheck status with 'curl -XGET http://localhost:9200/_snapshot/${REPOSITORY}/${BACKUP}/_status?pretty'"
