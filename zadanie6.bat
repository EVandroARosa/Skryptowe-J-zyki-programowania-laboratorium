@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Blad: Nie podano katalogu zrodlowego.
    echo Uzycie: zadanie6.bat ["C:\Users\Dom\PycharmProjects\Skryptowe Języki programowania_laboratorium\zadanie6.bat"]
    exit /b 1
)

set "SOURCE_DIR=%~1"

set "TOTAL=0"
for /d %%G in ("%SOURCE_DIR%\*") do (
    set /a TOTAL+=1
)

if %TOTAL% equ 0 (
    echo W podanym katalogu nie ma zadnych podfolderow do skompresowania.
    exit /b 0
)

set "COUNT=0"
for /d %%G in ("%SOURCE_DIR%\*") do (
    set /a COUNT+=1
    echo Kompresuje plik !COUNT! z %TOTAL%: %%~nG

    "C:\Program Files\7-Zip\7z.exe" a -tzip "%%~fG.zip" "%%~fG\*" >nul
)

echo.
echo Kompresja zakonczona sukcesem.
exit /b 0