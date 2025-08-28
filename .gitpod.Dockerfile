# 使用官方 PHP 镜像
FROM php:8.2-cli

# 安装必要扩展和工具
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    default-mysql-client \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 关键修复：安装到Gitpod用户有权限的目录
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/gitpod/.local/bin --filename=composer
ENV PATH="/home/gitpod/.local/bin:$PATH"

# 设置工作目录
WORKDIR /workspace

# 确保目录权限正确
RUN mkdir -p /home/gitpod/.local/bin && chown -R gitpod:gitpod /home/gitpod/.local/bin
