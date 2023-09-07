#!/bin/bash

cur_dir=$(cd $(dirname $0); pwd)


envsubst < /${cur_dir}/gitconfig > /root/.gitconfig
git config --list



mkdir -p "${PLUGIN_GIT_CACHE}"


mkdir -p /yyds/${PLUGIN_WORKSPACE_ID}/upper
mkdir -p /yyds/${PLUGIN_WORKSPACE_ID}/work
mkdir -p /yyds/${PLUGIN_WORKSPACE_ID}/${PLUGIN_WORKSPACE_NAME}
ln -fs /yyds/${PLUGIN_WORKSPACE_ID}/${PLUGIN_WORKSPACE_NAME} /workspace