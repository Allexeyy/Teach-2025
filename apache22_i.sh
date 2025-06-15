#!/bin/bash

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt update

# Установка Nginx
echo "Установка Apache2..."
sudo apt install -y apache2

#Копирование конфигов
sudo cp /home/alexey/repo/ports.conf /etc/apache2/ports.conf
sudo cp /home/alexey/repo/000-default.conf2 /etc/apache2/sites-available/000-default.conf
#cp /home/alexey/repo/index.html1 /var/www/html/index.html
sudo cp /home/alexey/repo/index.html2 /var/www/html/index.html

# Запуск и включение Apache2
echo "Запуск Nginx..."
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl restart apache2

# Проверка статуса Apache
echo "Проверка статуса Apache..."
echo "======================================="
ps afx | grep apache2
echo "======================================="
ss -ntlp
echo "======================================="
systemctl status apache2
echo "======================================="
echo "Установка Apache завершена!"

