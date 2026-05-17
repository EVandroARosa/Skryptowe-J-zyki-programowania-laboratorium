#!/bin/bash

# Sprawdzenie czy podano przynajmniej pierwszy argument (plik źródłowy)
if [ -z "$1" ]; then
    echo "Blad: Nie podano nazwy pliku zrodlowego."
    echo "Uzycie: $0 [STARA_NAZWA] [NOWA_NAZWA]"
    exit 1
fi

STARA_NAZWA="$1"
NOWA_NAZWA="$2"

# Sprawdzenie czy plik źródłowy w ogóle istnieje
if [ ! -f "$STARA_NAZWA" ]; then
    echo "Blad: Plik '$STARA_NAZWA' nie istnieje."
    exit 1
fi

# 1. Tworzenie kopii zapasowej z przyrostkiem .old
cp "$STARA_NAZWA" "${STARA_NAZWA}.old"
echo "Utworzono kopie zapasowa: ${STARA_NAZWA}.old"

# 2. Ustalamy nową nazwę, jeśli drugi argument jest pusty
if [ -z "$NOWA_NAZWA" ]; then
    NOWA_NAZWA="nowy"
fi

# 3. Zmiana nazwy oryginalnego pliku
mv "$STARA_NAZWA" "$NOWA_NAZWA"
echo "Zmieniono nazwe pliku '$STARA_NAZWA' na '$NOWA_NAZWA'."