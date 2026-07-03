#!/bin/bash

set -e

echo "Criando usuario zabbix..."

sudo -u postgres psql -tc "SELECT 1 FROM pg_roles WHERE rolname='zabbix'" | grep -q 1 || \
sudo -u postgres psql -c "CREATE USER zabbix WITH PASSWORD 'diegopenha';"

echo "Criando banco zabbix..."

sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname='zabbix'" | grep -q 1 || \
sudo -u postgres createdb -O zabbix zabbix

echo "Verificando schema..."

TABLES=$(PGPASSWORD='diegopenha' psql -h localhost -U zabbix -d zabbix -tAc "SELECT count(*) FROM information_schema.tables WHERE table_schema='public';")

if [ "$TABLES" = "0" ]; then
    echo "Importando schema..."
    zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | \
    PGPASSWORD='diegopenha' psql -h localhost -U zabbix -d zabbix
else
    echo "Schema já existe. Pulando importação."
fi

echo "Configurando senha do banco no Zabbix..."

sudo sed -i 's/^DBPassword=.*/DBPassword=diegopenha/' /etc/zabbix/zabbix_server.conf

echo "Reiniciando serviços..."

sudo systemctl restart postgresql
sudo systemctl restart zabbix-server

echo "Configuração concluída!"
