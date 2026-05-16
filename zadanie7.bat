@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Blad: Nie podano katalogu.
    goto :Usage
)
if "%~2"=="" (
    echo Blad: Nie podano rozszerzenia pliku (np. txt, pdf).
    goto :Usage
)

set "TARGET_DIR=%~1"
set "EXT=%~2"
set "OPTION=%~3"

if not exist "%TARGET_DIR%" (
    echo Blad: Podany katalog "%TARGET_DIR%" nie istnieje w systemie.
    exit /b 1
)

set "COUNTER=0"

if "%OPTION%"=="/s" (
    echo Przeszukuje katalog wraz z podkatalogami...
    for /r "%TARGET_DIR%" %%F in (*.%EXT%) do (
        if exist "%%F" set /a COUNTER+=1
    )
) else if "%OPTION%"=="" (
    echo Przeszukuje tylko glowny poziom katalogu...
    for %%F in ("%TARGET_DIR%\*.%EXT%") do (
        if exist "%%F" set /a COUNTER+=1
    )
) else (
    echo Blad: Nieznana opcja "%OPTION%". Dozwolona opcja to tylko /s.
    goto :Usage
)

echo Liczba plikow z rozszerzeniem .%EXT%: %COUNTER%
exit /b 0

:Usage
echo.
echo Uzycie: zadanie7.bat [SCIEZKA_DO_KATALOGU] [ROZSZERZENIE] [OPCJA /s]
echo Przyklad 1 (tylko ten katalog): zadanie7.bat C:\Users\Dom\Documents txt
echo Przyklad 2 (z podkatalogami): zadanie7.bat C:\Users\Dom\Documents txt /s
exit /b 1