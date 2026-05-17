#!/bin/bash

if command -v ip &> /dev/null; then

    BRAMA=$(ip route | grep default | awk '{print $3}')
elif command -v route &> /dev/null; then
    BRAMA=$(route -n | grep '0.0.0.0' | awk '{print $2}' | head -n 1)
else

    echo "Blad: W systemie brakuje narzedzi 'ip' lub 'route' do odczytania bramy." [cite: 877]
    exit 1 [cite: 877]
fi

if [ -z "$BRAMA" ]; then
    echo "Nie udalo sie znalezc adresu domyslnej bramy."
    exit 1
fi

echo "Wykryto brame o adresie: $BRAMA"
echo "Sprawdzam osiagalnosc bramy (wysylam 6 pakietow)..."

if ping -c 6 -i 0.25 -q "$BRAMA" > /dev/null 2>&1; then
    echo "Brama o adresie $BRAMA jest osiagalna."
else
    echo "Brama o adresie $BRAMA nie jest osiagalna."
fi