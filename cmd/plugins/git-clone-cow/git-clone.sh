#!/bin/bash
lower=/git/cow/${TASK_NAME}/merged
echo $lower
cd $lower
git init

git config remote.origin.url $GIT_REPO_URL
git fetch --tags --force --progress --verbose origin "+refs/heads/*:refs/remotes/origin/*" "+refs/tags/*:refs/tags/*"
git checkout --progress --force -B master origin/master
ls

