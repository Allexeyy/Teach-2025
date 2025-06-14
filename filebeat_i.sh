#!/bin/bash

#Установка пакута FileBeat
dpkg -i filebeat-8.9.1-amd64.deb 

#Копирование конфига
cp /home/alexey/repo/filebeat.yml /etc/filebeat/filebeat.yml

#Перезапуск после установки
systemctl enable filebeat
systemctl restart filebeat

echo "FileBeat для ELK на сервер NGINX установлен!"
