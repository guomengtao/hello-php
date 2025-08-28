# 使用官方 PHP 镜像
FROM php:8.2-cli

ENV DEBIAN_FRONTEND=noninteractive

# 安装必要工具和 PHP 扩展
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql mysqli

# 创建 /workspace 目录（可写）
RUN mkdir -p /workspace

# 安装 Composer 到 /workspace
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/workspace --filename=composer
ENV PATH="/workspace:$PATH"

# 设置工作目录
WORKDIR /workspace

# 复制项目文件
COPY . /workspace