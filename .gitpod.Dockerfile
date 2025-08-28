# 使用官方 PHP 镜像
FROM php:8.2-cli

# 安装必要扩展和工具
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    default-mysql-client \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql mysqli

# 安装 Composer 到用户可写目录
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/workspace --filename=composer
ENV PATH="/workspace:$PATH"

# 设置工作目录
WORKDIR /workspace

# 复制项目文件
COPY . /workspace