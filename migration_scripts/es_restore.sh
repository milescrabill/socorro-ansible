#!/bin/bash
set -u

if [[ $# -ne 3 ]]; then
    echo "Usage: $0 environment backup indices"
    exit 1
fi

REPOSITORY="socorro-es-migration-${1}"
BACKUP=$2
INDICES=$3

echo "WARNING: The indices $INDICES will be unavailable during the restore"
echo "Do you wish to proceed?"
# https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script/
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

echo "Requesting close of $INDICES so we can restore them"
curl -XPOST "http://localhost:9200/${INDICES}/_close?ignore_unavailable=true"

echo -e "\nRequesting restore of $INDICES from backup $BACKUP in $REPOSITORY"
curl -XPOST "http://localhost:9200/_snapshot/${REPOSITORY}/${BACKUP}/_restore" -d "{
   \"indices\": \"$INDICES\",
   \"include_global_state\": false
}"

echo -e "\nCheck status with 'curl -XGET http://localhost:9200/_cat/recovery?v'"
