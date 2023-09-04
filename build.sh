#!/usr/bin/env bash

set -eo pipefail

cur_dir=$(cd $(dirname $0); pwd)
version_build=`git rev-parse HEAD`
import_path="github.com/cheerego/uci"

BUILD_IMAGE=${BUILD_IMAGE:-golang:1.20.2-buster}
RUNTIME_IMAGE=${RUNTIME_IMAGE:-golang:1.20.2-buster}


function status() {
    echo -e "\033[35m >>>   $*\033[0;39m"
}

function build_go() {
    local module="$1"
    status "building ${module}..."
    docker run --rm \
        -v ${cur_dir}:/app \
        -w /app \
        ${BUILD_IMAGE} \
        sh -cx "go build -mod=vendor -ldflags \"-X 'main.BUILD_TIME=`date '+%Y-%m-%d %H:%M:%S'`' -X 'main.VERSION=`git rev-parse HEAD`'\" -o ./bin/${module} ${import_path}/cmd/${module}  && chmod +x ${cur_user}/bin"
}

function build_docker_image() {
    local module="$1"
    status "building docker image for ${module}..."
    sed -e "s/demo/${module}/g" \
        -e "s#image#${RUNTIME_IMAGE}#" \
        ${cur_dir}/Dockerfile \
        > ${cur_dir}/bin/Dockerfile.${module}
    docker build -t ${module}:${version_build} -t ${module}:latest -f ${cur_dir}/bin/Dockerfile.${module} ${cur_dir}/bin
    status ${module}:${version_build}
}


case "$1" in
    uci-messaging-server|uci-dispatch-server|uci-master|uci-uci-runner)
        build_go $1
        build_docker_image $1
        ;;
    *)
        echo "Usage: $0 uci-messaging-server | uci-dispatch-server | uci-master | uci-runner"
        ;;
esac

if [ "$2" = "--push" ]; then
    push_image $1
fi

if [ "$2" = "--tag" -a -n "$3" ]; then
    push_image $1 $3
fi

