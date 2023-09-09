#!/bin/bash


case "$1" in
    get)
        # 在此处根据传入的 URL 返回相应的凭据
        # 例如，您可以从环境变量或其他存储位置中检索凭据
#        if [ "$2" == "https://github.com" ]; then
            echo "username=$GIT_REPO_USERNAME"
            echo "password=$GIT_REPO_PASSWORD"
#        fi
        ;;
    *)
        # 处理其他命令（例如 store、erase 等）的逻辑
        # 根据需要进行实现
        ;;
esac