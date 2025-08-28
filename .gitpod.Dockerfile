# 使用官方 PHP 镜像（若需 8.4 版本，可改为 php:8.4-cli，与日志中 php8.4-gd 匹配）
FROM php:8.2-cli

# 关键：设置非交互式前端，消除 debconf 警告
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要扩展和工具（保留日志中出现的 sqlite3、mbstring、gd 等，避免依赖缺失）
RUN apt-get update && \
    apt-get install -y \
    default-mysql-client \
    unzip \
    git \
    curl \
    # 补充安装日志中提到的 PHP 扩展依赖（避免后续缺失）
    php-sqlite3 \
    php-mbstring \
    php-mysql \
    php-gd \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    # 清理缓存，减小镜像体积
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 核心修复：将 Composer 安装到 GitPod 用户有权限的目录（/home/gitpod/bin）
RUN mkdir -p /home/gitpod/bin && \  # 确保目录存在
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/gitpod/bin --filename=composer && \
    chmod +x /home/gitpod/bin/composer  # 确保可执行

# 将 Composer 目录加入系统 PATH，确保全局能调用 `composer` 命令
ENV PATH="/home/gitpod/bin:$PATH"

# 设置工作目录
WORKDIR /workspace

# 复制项目文件（GitPod 会自动挂载代码，但保留此命令不影响）
COPY . /workspace

# 可选：PHP 调试配置（显示错误、设置时区）
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/php.ini && \
    echo "display_errors = On" >> /usr/local/etc/php/php.ini && \
    echo "date.timezone = UTC" >> /usr/local/etc/php/php.ini