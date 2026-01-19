# 📜 WSL Automation Tool: macOS to Windows Server
Этот проект предназначен для автоматизации работы с WSL (Windows Subsystem for Linux) на удаленном сервере через SSH с вашего MacBook.

## 🚀 Основные возможности
Интерактивный выбор: Скрипт сканирует систему и предлагает выбрать дистрибутив (Ubuntu, Kali, Arch и др.).

Авто-коррекция: Автоматически вычищает Windows-окончания строк (\r), предотвращая ошибки в Linux.

Цветной вывод: Наглядная визуализация этапов работы (установка пакетов, мониторинг диска).

Интеграция с Lab: Выполняет все шаги из руководства по WSL (символьные ссылки, установка tree, проверка FS).

## 🛠 Быстрый старт
### 1. Настройка SSH на Windows
Запустите PowerShell от Администратора:

```PowerShell
Start-Service sshd
New-NetFirewallRule -Name "SSH" -DisplayName "SSH 22" -Direction Inbound -Protocol TCP -LocalPort 22 -Action Allow
```
### 2. Подготовка файлов
Склонируйте репозиторий или создайте два файла в папке пользователя:
```
script.ps1 — управляющий скрипт на PowerShell.
commands.sh — команды для выполнения внутри Linux.
```
Важно: Убедитесь, что commands.sh сохранен с окончаниями строк LF!

### 3. Запуск с macOS
Подключитесь по SSH и запустите "движок":

```Bash
ssh user@192.168.1.233
powershell.exe -ExecutionPolicy Bypass -File .\script.ps1
```
## 📂 Структура проекта
### script.ps1:

Обнаруживает дистрибутивы через wsl -l -q.

Решает проблему кодировок UTF-16/UTF-8.

Передает команды в Linux-контекст.

### commands.sh:

sudo apt update — обновление системы.

df -h — мониторинг дискового пространства.

ln -s — работа с символьными ссылками.

### 💡 DevOps Tips
Для входа без пароля используйте: ssh-copy-id user@ip.

Если видите ошибку \r: command not found, проверьте статус LF в нижнем баре VS Code.