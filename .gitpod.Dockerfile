# 使用官方 PHP CLI 镜像
FROM php:8.2-cli

# 安装必要扩展（SQLite 已自带 PDO_SQLITE）
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    && docker-php-ext-install pdo pdo_sqlite

# 设置工作目录
WORKDIR /workspace

# 复制项目文件
COPY . /workspace