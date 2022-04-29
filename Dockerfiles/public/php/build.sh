#!/bin/bash
image=cheerego-docker.pkg.coding.net/registry/public/php
tag=8-fpm-20220409

newImage=${image}:${tag}

docker build -t php .
docker tag php ${newImage}
docker push ${newImage}