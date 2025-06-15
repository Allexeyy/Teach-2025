#!/bin/bash
# Установка Prometheus
sudo apt update
sudo apt install prometheus prometheus-node-exporter -y

echo "Установка GRAFANA и дополнительного пакета"
sudo apt install musl -y
sudo dpkg -i grafana_11.6.1_amd64-224190-5beb3f.deb
sudo systemctl daemon-reload
sudo systemctl enable grafana-server

echo "Установка Prometheus + Grafana завершена!"

# Проверка статуса Prometheus
echo "======================================="
ss -ntlp
echo "======================================="
ps afx | grep prometheus
echo "======================================="
systemctl status prometheus

# Проверка статуса Grafana
echo "======================================="
ss -ntlp
echo "======================================="
ps afx | grep grafana
echo "======================================="
sudo systemctl restart grafana-server.service
systemctl status grafana-server.service
