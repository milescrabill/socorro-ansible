#!/bin/bash
set -u

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 environment"
    exit 1
fi

REPOSITORY="socorro-es-migration-${1}"

echo "Requesting initializing repository $REPOSITORY backed by S3 bucket $REPOSITORY"
curl -XPUT "http://localhost:9200/_snapshot/$REPOSITORY" -d "{
  \"type\": \"s3\",
  \"settings\": {
    \"bucket\": \"$REPOSITORY\",
    \"region\": \"us-west-2\"
  }
}"

echo -e "\nCheck status with 'curl -XGET http://localhost:9200/_snapshot/'"
