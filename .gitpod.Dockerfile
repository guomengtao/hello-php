# 使用官方 PHP 镜像
FROM php:8.2-cli

# 避免 debconf 弹出界面
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要工具和 PHP 扩展
RUN apt-get update && apt-get install -y \
    default-mysql-client \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql mysqli

# 安装 Composer 到 /workspace（可写目录）
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/workspace --filename=composer
ENV PATH="/workspace:$PATH"

# 设置工作目录
WORKDIR /workspace

# 复制项目文件
COPY . /workspace