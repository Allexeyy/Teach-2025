#!/bin/bash

#Устновка java и копирование его конфига
sudo apt update
sudo apt install default-jdk -y

#Устновка ElasticSearch и копирование его конфига
sudo dpkg -i elasticsearch-8.9.1-amd64.deb
sudo cp /home/alexey/repo/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo cp /home/alexey/repo/jvm.options /etc/elasticsearch/jvm.options.d/jvm.options
sudo systemctl daemon-reload
sudo systemctl enable --now elasticsearch.service

#Устновка Kibana и копирование его конфига
sudo dpkg -i kibana-8.9.1-amd64.deb
sudo cp /home/alexey/repo/kibana.yml /etc/kibana/kibana.yml
sudo systemctl daemon-reload
sudo systemctl enable --now kibana.service
sudo systemctl status kibana.service

#Устновка Logstash и копирование его конфига
sudo dpkg -i logstash-8.9.1-amd64.deb
sudo cp /home/alexey/repo/logstash.yml /etc/logstash/logstash.yml
sudo cp /home/alexey/repo/logstash-nginx-es.conf /etc/logstash/conf.d/logstash-nginx-es.conf
sudo systemctl enable --now logstash.service
sudo systemctl restart logstash.service

#Устновка FileBeat и копирование его конфига
#Примечание при установке на текущий сервер требуется установить WEB-сурвер на текущий сервер
#dpkg -i filebeat-8.9.1-amd64.deb
#cp /home/alexey/repo/filebeat.yml /etc/filebeat/filebeat.yml
#systemctl enable filebeat
#systemctl restart filebeat

