#!/bin/bash

BACKUP_DIR="/home/alexey/backup/"

DATE=$(date +"%Y%m%d_%H%M%S")

mkdir -p "$BACKUP_DIR"

BINLOG_POS=$(mysql -e "SHOW MASTER STATUS;" | awk 'NR==2 {print $1, $2}')

if [ -z "BINLOG_POS" ]; then
	echo "Не удалось получить информации о бинлоге."
	exit 1
fi

DATABASES=$(mysql -e "SHOW DATABASES;" | awk '{if(NR>1) print $1}')
for DB in $DATABASES; do
	if [[ "$DB" == "information_schema" || "$DB" == "perfomance_schema"  || "$DB" == "mysql" || "$DB" == "sys" ]]; 
	then continue
	fi

mysqldump --add-drop-table --add-locks --create-options --triggers --routines --disable-keys --extended-insert --single-transaction --set-charset --source-data "$DB" > "$BACKUP_DIR/$DB_$DATE.sql"

	if [ "%?" -eq 0 ]; then
		echo "Бэкап БД $DB завершен."
	else
		echo "Ошибка при бэкапе БД $DB."
	fi
done

echo "Последний бинлог: $BINLOG_POS" > "$BACKUP_DIR/binlog_position_$DATE.txt"

echo "Все бэкапы БД завершены!"
