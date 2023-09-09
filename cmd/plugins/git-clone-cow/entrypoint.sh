#!/bin/bash

cur_dir=$(cd $(dirname $0); pwd)

cp ${cur_dir}/gitconfig  /root/.gitconfig

mkdir -p /git/${TASK_NAME}/lower
mkdir -p /git/${TASK_NAME}/merged
mkdir -p /git/${TASK_NAME}/upper
mkdir -p /git/${TASK_NAME}/woker


lower=/git/${TASK_NAME}/lower
upper=/git/${TASK_NAME}/upper
work=/git/${TASK_NAME}/work
merged=/git/${TASK_NAME}/merged


echo lower=$lower
echo upper=$upper
echo work=$work
echo merged=$merged
bash git-clone.sh









