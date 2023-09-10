#!/bin/bash

cur_dir=$(cd $(dirname $0); pwd)

cp ${cur_dir}/gitconfig  /root/.gitconfig

cow_lower=/git/cow/${TASK_NAME}/lower
cow_upper=/git/cow/${TASK_NAME}/upper
cow_work=/git/cow/${TASK_NAME}/work
cow_merged=/git/cow/${TASK_NAME}/merged


mkdir -p "${cow_lower}" "${cow_upper}" "${cow_work}" "${cow_merged}"

echo "Lower file" > "${cow_lower}/filelower.txt"
echo "Upper file" > "${cow_upper}/fileupper.txt"
echo "work file" > "${cow_work}/fileworker.txt"

bash git-clone.sh


mount -t overlay overlay -o lowerdir=$cow_lower,upperdir=$cow_upper,workdir=$cow_work $cow_merged


