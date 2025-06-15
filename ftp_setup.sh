#!/bin/bash

# Функция для проверки успешности выполнения предыдущей команды
check_success() {
    if [ $? -ne 0 ]; then
        echo "Ошибка на этапе: $1" >&2
        exit 1
    fi
}

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt update
check_success "обновление списка пакетов"

# Установка vsftpd
echo "Установка vsftpd..."
sudo apt install -y vsftpd
check_success "установка vsftpd"

# Резервное копирование оригинального конфигурационного файла
echo "Создание резервной копии конфигурационного файла vsftpd..."
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

# Настройка конфигурации vsftpd
echo "Настройка конфигурации vsftpd..."
sudo cp /home/alexey/repo/vsftpd.conf /etc/vsftpd.conf

# Перезапуск службы vsftpd для применения настроек
echo "Перезапуск службы vsftpd..."
sudo systemctl restart vsftpd
check_success "перезапуск vsftpd"

# Активация службы в автозагрузке
echo "Активация службы vsftpd в автозагрузке..."
sudo systemctl enable vsftpd
check_success "активация в автозагрузке"

echo "vsftpd успешно установлен и настроен!"
