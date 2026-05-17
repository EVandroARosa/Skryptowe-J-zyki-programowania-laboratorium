import argparse
import subprocess
import sys


def test_connection():
    # add_help=False pozwala na przejęcie flagi -h dla hosta zgodnie z instrukcją profesora
    parser = argparse.ArgumentParser(description="Testowanie polaczenia sieciowego.", add_help=False)

    # Ręcznie dodajemy pomoc pod dłuższą flagą, aby zwolnić krótkie '-h'
    parser.add_argument("--help", action="help", help="Pokaz te wiadomosc pomocy i wyjdz")

    parser.add_argument("-h", required=True, help="Adres hosta docelowego")
    parser.add_argument("-w", action="store_true", help="Zapisz podsumowanie do pliku")
    parser.add_argument("-f", help="Nazwa pliku raportu")

    args = parser.parse_args()

    if args.w and not args.f:
        print("Blad: Jezeli uzywasz opcji -w, musisz podac nazwe pliku przy uzyciu -f.")
        return

    host = args.h
    pakiety = 4
    odebrane = 0
    bledy = 0

    print(f"Testowanie polaczenia z hostem: {host}...")

    for i in range(pakiety):
        # Parametr '-n 1' dla Windows wysyła 1 pakiet. '-w 1000' to timeout 1 sekunda.
        wynik = subprocess.run(["ping", "-n", "1", "-w", "1000", host], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        # Jeśli ping się powiódł, returncode wynosi 0
        if wynik.returncode == 0:
            odebrane += 1
        else:
            bledy += 1

    procent = (odebrane / pakiety) * 100

    if procent == 100:
        komunikat = "komunikacja sprawna (100% odebranych)"
    elif procent > 0:
        komunikat = "komunikacja z przerwami (odebranych >0 <100)"
    else:
        komunikat = "komunikacja niemozliwa (odebranych 0%)"

    podsumowanie = (
        f"--- PODSUMOWANIE RUCHU DLA HOSTA: {host} ---\n"
        f"Wyslano pakietow: {pakiety}\n"
        f"Odebrano pakietow: {odebrane}\n"
        f"Ilosc bledow: {bledy}\n"
        f"Status: {komunikat}\n"
    )

    print(podsumowanie)

    if args.w:
        with open(args.f, "w", encoding="utf-8") as f:
            f.write(podsumowanie)
        print(f"Podsumowanie zostalo zapisane do pliku: {args.f}")


if __name__ == "__main__":
    test_connection()