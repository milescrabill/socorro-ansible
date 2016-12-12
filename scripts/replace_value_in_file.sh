set +x
set +u

OLD=$1
NEW=$2
FILE=$3

sed -i "s/${OLD}/${NEW}/g" ${FILE}
grep ${NEW} ${FILE}
