[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function Get-WslSelection {
    # 1. Получаем и очищаем список дистрибутивов
    $distros = wsl -l -q | ForEach-Object { $_.Trim().Replace("`0", "") } | Where-Object { $_ -ne "" }

    if ($distros.Count -eq 0) {
        Write-Host "Дистрибутивы не найдены. Сначала установите Linux через 'wsl --install'." -ForegroundColor Red
        return $null
    }

    # 2. Выводим меню пользователю
    Write-Host "`n=== Доступные дистрибутивы WSL ===" -ForegroundColor Cyan
    for ($i = 0; $i -lt $distros.Count; $i++) {
        Write-Host "[$($i + 1)] $($distros[$i])" -ForegroundColor White
    }
    Write-Host "==================================" -ForegroundColor Cyan

    # 3. Запрашиваем ввод
    $choice = Read-Host "Введите номер дистрибутива для работы"

    # 4. Проверяем корректность ввода
    if ($choice -as [int] -and $choice -ge 1 -and $choice -le $distros.Count) {
        return $distros[$choice - 1]
    } else {
        Write-Host "Неверный выбор. Попробуйте снова." -ForegroundColor Red
        return $null
    }
}

function Run-LinuxScript {
    param ([string]$distroName, [string]$scriptPath)

    if (Test-Path $scriptPath) {
        Write-Host "`nКопирование и запуск сценария в $distroName..." -ForegroundColor Green
        
        $linuxPath = "/tmp/commands.sh"
        
        # Читаем файл, удаляем символы `r (возврат каретки) и записываем в WSL
        $content = Get-Content $scriptPath -Raw
        $content = $content -replace "`r", ""
        
        # Передаем "чистый" текст в файл внутри Linux
        $content | wsl -d $distroName -e bash -c "cat > $linuxPath"
        
        # Запускаем интерактивно
        wsl -d $distroName -e bash $linuxPath
    } else {
        Write-Host "Файл $scriptPath не найден!" -ForegroundColor Red
    }
}

# --- Основной запуск ---
$selectedDistro = Get-WslSelection

if ($selectedDistro) {
    Run-LinuxScript -distroName $selectedDistro -scriptPath "C:\Users\Hamka\commands.sh"
}