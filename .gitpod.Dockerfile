FROM php:8.2-cli

# 安装 git 和 curl（最小依赖）
RUN apt-get update && apt-get install -y git curl unzip && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY . /workspace