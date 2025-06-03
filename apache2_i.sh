#!/bin/bash

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt update

# Установка Nginx
echo "Установка Apache2..."
sudo apt install -y apache2

#Копирование конфигов
cp /home/alexey/repo/ports.conf /etc/apache2/ports.conf
cp /home/alexey/repo/000-default.conf /etc/apache2/sites-available/000-default.conf

# Запуск и включение Apache2
echo "Запуск Nginx..."
sudo systemctl start apache2
sudo systemctl enable apache2

# Проверка статуса Apache
echo "Проверка статуса Apache..."
sudo systemctl status apache2

echo "Установка Apache завершена!"
