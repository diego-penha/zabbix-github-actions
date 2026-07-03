#!/bin/bash

echo "Atualizando pacotes..."
sudo apt update

echo "Instalando Zabbix Agent..."
sudo apt install -y zabbix-agent2

echo "Verificando serviço..."
sudo systemctl enable zabbix-agent2
sudo systemctl restart zabbix-agent2

echo "Status:"
systemctl is-active zabbix-agent2
