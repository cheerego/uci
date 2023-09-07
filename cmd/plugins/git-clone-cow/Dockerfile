FROM golang:1.20.2-buster


WORKDIR /app


RUN sed -i 's#http://deb.debian.org#https://mirrors.cloud.tencent.com#g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y git git-lfs

ADD . .

CMD  ./git-clone-cow run