Инструкция к теме
"Настройка и конфигурирование базовых Linux-серверов предприятия"
Предполагается следующая конфигурация

NGINX -----> Apache2 _ 1					  (GTID)
  |     \					MYSQL8(master) <---------> MYSQL8(slave)
  |       -> Apache2 _ 2
  |							(Prometeus <---> Grafana)
  |(FileBeat)
   --------> ELK (ElastikSearch, LogStash, Kibana)

Прдварительно проведена подготовка: 
- установка server Ubuntu 22.04 LTS (7 VM)
- настройка сети, каждая машина получила статические адреса
	- NGINX				192.168.1.50
	- Apache2 _ 1	      		192.168.1.51
	- Apache2 _ 2	      		192.168.1.52
	- MYSQL8(master)     		192.168.1.53
	- MYSQL8(slave)    		192.168.1.54
	- Prometeus - Grafana	  	192.168.1.49
	- ELK			        192.168.1.48
    репозитории есть конфигурационные файлы для netplan, копируем один из них, правим сетевые параметры и применяем (netplan apply)
на каждом сервере установлен GIT и дополнительный скрипт установки привязка к 
- https://github.com/Allexeyy/Teach-2025.git
+ скрипт FTP-сервера для записи файлов большого размера с машины локальной сети
на сервера переписаны NGINX (filebeat), Prometeus/Grafana (grafana), ELK (logstash, elastiksearch, kibana)

Для установки и конфигурирования каждого сервера написаны bash-скрипты.

Последовательность установки следующая:
1. NGINX 		      		- nginx_i.sh
2. Apache2 		    		- apache2_i.sh
3. Apache2 		    		- apache22_i.sh
4. MYSQL8 		    		- mysql_master_setup.sh
5. MYSQL8 		    		- mysql_slave_setup.sh
6. Prometeus/Grafana			- mon_i.sh
7. ELK 				    	- elk_i.sh запускаем из папки где хранятся файлы elk (/home/alexey/ftp)
8. NGINX 			      	- filebeat_i.sh
