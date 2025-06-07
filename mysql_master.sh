#!/bin/bash
# Переменные
REPL_USER="repl"
REPL_PASS="repl"
DB_NAME="my_db"
MASTER_IP="192.168.1.53"  # IP master сервера
SLAVE_IP="192.168.1.54"   # IP slave сервера

# Создание пользователя для репликации
mysql -u root -p -e "CREATE USER '$REPL_USER'@'%' IDENTIFIED BY '$REPL_PASS';"
mysql -u root -p -e "GRANT REPLICATION SLAVE ON *.* TO '$REPL_USER'@'%';"
mysql -u root -p -e "FLUSH PRIVILEGES;"
