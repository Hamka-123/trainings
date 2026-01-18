#!/bin/bash

# --- Объявляем цвета ---
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color (Сброс цвета)

echo -e "${CYAN}--- Запуск Bash-скрипта внутри WSL ---${NC}"
echo -e "Вы работаете в дистрибутиве: ${YELLOW}$(cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2 | tr -d '\"')${NC}"

# Обновляем список пакетов
echo -e "${BLUE}Обновление пакетов...${NC}"
sudo apt update -y

# Проверяем место на диске до (стр. 20 лабы)
echo -e "${GREEN}Место на диске ДО:${NC}"
df -h /

# Устанавливаем tree, если его нет
echo -e "${BLUE}Установка утилиты...${NC}"
sudo apt install htop -y

# Проверяем место на диске ПОСЛЕ
echo -e "${GREEN}Место на диске ПОСЛЕ:${NC}"
df -h /

# Создаем символьную ссылку для теста (стр. 19)
echo -e "${CYAN}Создаем структуру файлов...${NC}"
mkdir -p ~/devops_lab
touch ~/devops_lab/target_file.txt
ln -sf ~/devops_lab/target_file.txt ~/devops_lab/link_to_file

# Финальный вывод с подсветкой ссылки
echo -e "${YELLOW}Результат создания ссылки:${NC}"
ls -l --color=always ~/devops_lab/

echo -e "${GREEN}Готово! Тик-так!${NC}"