# 使用官方 PHP CLI 镜像
FROM php:8.2-cli

# 安装 MySQL 客户端、PHP 扩展
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    default-mysql-server \
    default-mysql-client \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql mysqli

# 设置工作目录
WORKDIR /workspace

# 复制项目文件
COPY . /workspace