#!/bin/bash

#Установка пакута FileBeat
sudo dpkg -i filebeat-8.9.1-amd64.deb 

#Копирование конфига
sudo cp /home/alexey/repo/filebeat.yml /etc/filebeat/filebeat.yml

#Перезапуск после установки
sudo systemctl enable filebeat
sudo systemctl restart filebeat

echo "FileBeat для ELK на сервер NGINX установлен!"
