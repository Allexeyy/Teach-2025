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
check_success "резервное копирование конфигурации"

# Настройка конфигурации vsftpd
echo "Настройка конфигурации vsftpd..."

# Включаем доступ для локальных пользователей
sudo bash -c "echo 'local_enable=YES' >> /etc/vsftpd.conf"  # Разрешает локальным пользователям вход в FTP

# Разрешаем запись для локальных пользователей
sudo bash -c "echo 'write_enable=YES' >> /etc/vsftpd.conf"  # Позволяет локальным пользователям загружать файлы

# Включаем chroot для локальных пользователей
sudo bash -c "echo 'chroot_local_user=YES' >> /etc/vsftpd.conf"  # Ограничивает пользователей их домашними директориями

# Стилизация директории при входе
sudo bash -c "echo 'allow_writeable_chroot=YES' >> /etc/vsftpd.conf"  # Позволяет запись в chroot-окружении.

# Разрешаем пассивный режим
sudo bash -c "echo 'pasv_enable=YES' >> /etc/vsftpd.conf"  # Включает пассивный режим FTP
sudo bash -c "echo 'pasv_min_port=10000' >> /etc/vsftpd.conf"  # Задает минимальный порт для пассивного режима
sudo bash -c "echo 'pasv_max_port=10100' >> /etc/vsftpd.conf"  # Задает максимальный порт для пассивного режима

# Перезапуск службы vsftpd для применения настроек
echo "Перезапуск службы vsftpd..."
sudo systemctl restart vsftpd
check_success "перезапуск vsftpd"

# Активация службы в автозагрузке
echo "Активация службы vsftpd в автозагрузке..."
sudo systemctl enable vsftpd
check_success "активация в автозагрузке"

echo "vsftpd успешно установлен и настроен!"
