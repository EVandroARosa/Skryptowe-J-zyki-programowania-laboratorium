@echo off
if "%~1"=="" (
    echo Blad: Nie podano litery partycji.
    exit /b 1
)

call procedura.bat %~1

if %errorlevel% equ 0 (
    echo [Główny skrypt] Wynik: Partycja %~1: istnieje.
    exit /b 0
) else (
    echo [Główny skrypt] Wynik: Partycji %~1: brak.
    exit /b 1
)