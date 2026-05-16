@echo off
if "%~1"=="" (
    echo Blad: Nie podano litery partycji jako argumentu.
    echo Uzycie: zadanie1.bat [LITERA_PARTYCI]
    exit /b 1
)

vol %~1: >nul 2>nul

if %errorlevel% equ 0 (
    echo Partycja %~1: istnieje w systemie.
    exit /b 0
) else (
    echo Partycji %~1: brak w systemie.
    exit /b 1
)