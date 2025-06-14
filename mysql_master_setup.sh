#!/bin/bash
# Переменные
REPL_USER="repl"
REPL_PASS="repl"
DB_NAME="my_db"
MASTER_IP="192.168.1.53"  # IP master сервера
SLAVE_IP="192.168.1.54"   # IP slave сервера

sudo -i
hostnamectl set-hostname mysql-master

# Функция для проверки успешности выполнения предыдущей команды
check_success() {
    if [ $? -ne 0 ]; then
        echo "Ошибка на этапе: $1" >&2
        exit 1
    fi
}

# Установка MySQL
echo "Установка MySQL..."
sudo apt update
sudo apt install -y mysql-server mysql-client
check_success "установка MySQL"

#Копирование конфига
sudo cp /home/alexey/repo/mysqld.cnf.master /etc/mysql/mysql.conf.d/mysqld.cnf

# Перезапуск MySQL
sudo systemctl restart mysql
check_success "перезапуск MySQL"
echo "============================================================"
systemctl status mysql
echo "============================================================"
ss -ntlp
echo "============================================================"
ps -afx | grep mysql

# Создание пользователя для репликации
mysql -u root -p -e "CREATE USER '$REPL_USER'@'%' IDENTIFIED BY '$REPL_PASS';"
mysql -u root -p -e "GRANT REPLICATION SLAVE ON *.* TO '$REPL_USER'@'%';"
mysql -u root -p -e "FLUSH PRIVILEGES;"
