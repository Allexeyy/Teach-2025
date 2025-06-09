#!/bin/bash
# Переменные
REPL_USER="repl"
REPL_PASS="repl"
MASTER_IP="192.168.1.53"  # IP master сервера
SLAVE_IP="192.168.1.54"   # IP slave сервера

mysql -u root -e "STOP REPLICA;";
mysql -u root -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='$MASTER_IP', SOURCE_USER='$REPL_USER', SOURCE_PASSWORD='$REPL_PASS', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1;";
mysql -u root -e "START REPLICA;";

