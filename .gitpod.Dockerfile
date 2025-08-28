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

# 安装Composer到Gitpod用户目录（确保权限）
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/gitpod/bin --filename=composer
ENV PATH="/home/gitpod/bin:$PATH"

# 设置工作目录为Gitpod工作区
WORKDIR /workspace

# 配置PHP设置
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/php.ini && \
    echo "display_errors = On" >> /usr/local/etc/php/php.ini && \
    echo "date.timezone = UTC" >> /usr/local/etc/php/php.ini

# Gitpod特定配置 - 确保正确的用户权限
RUN chown -R gitpod:gitpod /home/gitpod
    