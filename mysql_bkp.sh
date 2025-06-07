#!/bin/bash

# Переменные
BACKUP_DIR="/home/alexey/backup"  	      # Укажите директорию для сохранения бэкапов
EXCLUDED_DBS=("information_schema" "performance_schema" "mysql" "sys")  # Системные базы

# Создание директории для бэкапов, если не существует
mkdir -p "$BACKUP_DIR"

# Получение списка баз данных, исключая системные
DBS=$(sudo mysql -u root -e "SHOW DATABASES;" | grep -Ev '\b($(IFS=|; echo "${EXCLUDED_DBS[*]}"))\b')

# Обход каждой базы данных и создание полного бэкапа
for DB in $DBS; do
    echo "Создание бэкапа базы данных: $DB"
    BACKUP_FILE="$BACKUP_DIR/${DB}_$(date +'%Y%m%d_%H%M%S').sql"

    # Создание бэкапа базы данных
    sudo mysqldump -u root --databases "$DB" > "$BACKUP_FILE"
    
    # Проверка успешности выполнения команды
    if [ $? -eq 0 ]; then
        echo "Бэкап для базы данных $DB успешно создан: $BACKUP_FILE"
    else
        echo "Ошибка при создании бэкапа для базы данных $DB"
    fi
done

# Получение позиции бинарного лога
echo "Получение позиции бинарного лога..."
BINLOG_POS=$(sudo mysql -u root -e "SHOW MASTER STATUS;" | awk 'NR==2 {print $1, $2}')
echo "Позиция бинарного лога: $BINLOG_POS"

echo "Бэкап завершен!"
