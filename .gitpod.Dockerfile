# 使用官方 PHP 镜像
FROM php:8.2-cli

# 安装必要工具和 MySQL
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    default-mysql-server default-mysql-client \
    unzip git curl && \
    docker-php-ext-install pdo pdo_mysql mysqli

# 设置可写目录安装 Composer
RUN mkdir -p /workspace/composer && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/workspace/composer --filename=composer
ENV PATH="/workspace/composer:$PATH"

# 设置工作目录
WORKDIR /workspace

# 复制项目文件
COPY . /workspace