FROM node:14

# install vscode and extension
RUN curl -fsSL https://code-server.dev/install.sh | bash

RUN code-server --install-extension redhat.vscode-yaml &&\
    code-server --install-extension orta.vscode-jest &&\
    code-server --install-extension dbaeumer.vscode-eslint &&\
    code-server --install-extension eamodio.gitlens &&\
    echo done

# 指定字符集支持命令行输入中文（根据需要选择字符集）
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8