# 基础镜像
FROM ubuntu:22.04

# 使用 root
USER root

# 避免交互式安装报错
ENV DEBIAN_FRONTEND=noninteractive

# 安装 PHP +常用扩展 + MySQL 客户端 + curl
RUN apt-get update && apt-get install -y \
    php-cli php-mbstring php-xml php-mysql unzip curl mysql-client \
    && apt-get clean

# 安装 Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 创建工作目录
WORKDIR /workspace

# 暴露 PHP 内置服务器端口
EXPOSE 8080

# 暴露 MySQL 端口（如果想直接外部访问）
EXPOSE 3306
