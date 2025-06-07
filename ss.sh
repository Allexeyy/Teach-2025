#!/bin/bash

# Параметры для подключения к GitHub
GITHUB_USERNAME="Allexeyy"
GITHUB_EMAIL="alexey.pasunkin@gmail.com"
GITHUB_REPO_URL="https://github.com/Allexeyy/Teach-2025.git"

# Установка Git
echo "Установка Git..."
sudo apt update
sudo apt install -y git

# Настройка Git
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$GITHUB_EMAIL"

# Создание директории repo
echo "Создание директории repo в корневой папке пользователя..."
mkdir -p ~/repo
cd ~/repo

# Инициализация локального Git-репозитория
echo "Инициализация локального Git-репозитория..."
git init

# Добавление удаленного репозитория
echo "Добавление удаленного репозитория..."
git remote add origin "$GITHUB_REPO_URL"

# Добавление всех файлов в репозиторий, их коммит и синхронизация с GitHub
echo "Синхронизация файлов с GitHub..."
#git add .
#git commit -m "Initial commit"
git pull origin main
