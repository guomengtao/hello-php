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

# 正确安装Composer到用户有权限的目录
RUN mkdir -p /home/gitpod/bin && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/gitpod/bin --filename=composer && \
    chmod +x /home/gitpod/bin/composer
ENV PATH="/home/gitpod/bin:$PATH"

# 设置工作目录
WORKDIR /workspace

# 复制项目文件
COPY . /workspace

# PHP配置优化
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/php.ini && \
    echo "display_errors = On" >> /usr/local/etc/php/php.ini && \
    echo "date.timezone = UTC" >> /usr/local/etc/php/php.ini
