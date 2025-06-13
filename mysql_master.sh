#!/bin/bash
# Переменные
REPL_USER="repl"
REPL_PASS="repl"
DB_NAME="my_db"
MASTER_IP="192.168.1.53"  # IP master сервера
SLAVE_IP="192.168.1.54"   # IP slave сервера

# Создание пользователя для репликации
sudo -i
mysql -u root -e "CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'repl';"
mysql -u root -e "GRANT REPLICATION SLAVE ON *.* TO repl@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
