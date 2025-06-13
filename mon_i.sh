#!/bin/bash
# Установка Prometheus
apt install prometheus prometheus-node-exporter

echo "Установка GRAFANA и дополнительного пакета"
sudo apt install musl
sudo dpkg -i grafana_11.6.1_amd64-224190-5beb3f.deb

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
systemctl status grafana-server.service
