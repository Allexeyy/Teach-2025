#!/bin/bash

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt update

# Установка Nginx
echo "Установка Nginx..."
sudo apt install -y nginx

# Копирование конфигов
cp /home/alexey/repo/nginx.conf /etc/nginx/nginx.conf
cp /home/alexey/repo/default /etc/nginx/sites-available/default

# Запуск и включение Nginx
echo "Запуск Nginx..."
sudo systemctl start nginx
sudo systemctl enable nginx

# Проверка статуса Nginx
echo "Проверка статуса Nginx..."
sudo systemctl status nginx

echo "Установка Nginx завершена!"
