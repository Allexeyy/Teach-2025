#!/bin/bash
# Переменные
REPL_USER="repl"
REPL_PASS="repl"
DB_NAME="my_db"
MASTER_IP="192.168.1.53"  # IP master сервера
SLAVE_IP="192.168.1.54"   # IP slave сервера

sudo hostnamectl set-hostname mysql-slave

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
sudo cp /home/alexey/repo/mysqld.cnf.slave /etc/mysql/mysql.conf.d/mysqld.cnf

# Перезапуск MySQL
sudo systemctl restart mysql
check_success "перезапуск MySQL"
echo "============================================================"
systemctl status mysql
echo "============================================================"
ss -ntlp
echo "============================================================"
ps -afx | grep mysql
echo "============================================================"

# Создание репликации
sudo mysql -u root -e "STOP REPLICA;";
sudo mysql -u root -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='$MASTER_IP', SOURCE_USER='$REPL_USER', SOURCE_PASSWORD='$REPL_PASS', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1;";
sudo mysql -u root -e "START REPLICA;";
