#!/bin/bash

# Переменные
CONTAINER_NAME="astra-linux"
CONTAINER_TEMPLATE="astralinux-se"

# Установка LXC
sudo apt update
sudo apt install -y lxc lxc-astra

# Создание LXC контейнера
sudo lxc-create -t $CONTAINER_TEMPLATE -n $CONTAINER_NAME

# Запуск контейнера
sudo lxc-start -n $CONTAINER_NAME

# Ожидание запуска контейнера
sleep 10

# Установка и запуск Wiki.js + Postgres внутри контейнера
sudo lxc-attach -n $CONTAINER_NAME -- bash -c "
    # Установка необходимых пакетов
    apt update &&
    apt install -y curl build-essential postgresql postgresql-contrib wget

    # Установка Node.js конкретной версии
    wget https://nodejs.org/dist/v16.20.2/node-v16.20.2-linux-x64.tar.xz &&
    tar -xvf node-v16.20.2-linux-x64.tar.xz -C /opt

    # Настройка PostgreSQL
    sudo -u postgres psql -c \"CREATE DATABASE wiki;\" &&
    sudo -u postgres psql -c \"CREATE USER wikijs WITH ENCRYPTED PASSWORD 'wikijsrocks';\" &&
    sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE wiki TO wikijs;\"
    echo 'ac_ignore_maclabel = on' >> /etc/postgresql/11/main/postgresql.conf &&
    systemctl restart postgresql &&
    
    # Клонирование репозитория Wiki.js
    mkdir /var/www && 
    cd /var/www &&
    wget https://github.com/Requarks/wiki/releases/latest/download/wiki-js.tar.gz &&
    mkdir /var/www/wiki &&
    tar xzf wiki-js.tar.gz -C ./wiki &&
    cd ./wiki

    # Копирование конфигурационного файла
    mv config.sample.yml config.yml

    # Установка зависимостей
    /opt/node-v16.20.2-linux-x64/bin/node /opt/node-v16.20.2-linux-x64/bin/npm install --legacy-peer-deps

    # Запуск сервера
    /opt/node-v16.20.2-linux-x64/bin/node server
"
