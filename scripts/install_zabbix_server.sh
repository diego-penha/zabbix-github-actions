#!/bin/bash

set -e

echo "Atualizando repositórios..."
sudo apt update

echo "Instalando PostgreSQL..."
sudo apt install -y postgresql

echo "Adicionando repositório Zabbix..."
wget https://repo.zabbix.com/zabbix/8.0/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_8.0+ubuntu26.04_all.deb

sudo dpkg -i zabbix-release_latest_8.0+ubuntu26.04_all.deb

sudo apt update

echo "Instalando Zabbix Server..."
sudo apt install -y \
zabbix-server-pgsql \
zabbix-frontend-php \
zabbix-apache-conf \
zabbix-sql-scripts \
zabbix-agent2 \
php-pgsql

echo "Instalação concluída."
