import argparse
import os


def szukaj_pustych_plikow():
    parser = argparse.ArgumentParser(description="Szukanie pustych plikow .txt.")
    parser.add_argument("-k", "--katalog", required=True, help="Sciezka do katalogu startowego")
    parser.add_argument("-r", "--rekurencyjnie", action="store_true", help="Przeszukuj podkatalogi")

    args = parser.parse_args()

    if not os.path.exists(args.katalog):
        print(f"Blad: Podany katalog '{args.katalog}' nie istnieje.")
        return

    znalezione = 0

    if args.rekurencyjnie:
        print(f"Szukam pustych plikow w '{args.katalog}' oraz podkatalogach...")
        # os.walk automatycznie przechodzi przez całe drzewo folderów
        for root, dirs, files in os.walk(args.katalog):
            for file in files:
                if file.endswith(".txt"):
                    full_path = os.path.join(root, file)
                    if os.path.getsize(full_path) == 0:
                        print(f"Znaleziono pusty plik: {full_path}")
                        znalezione += 1
    else:
        print(f"Szukam pustych plikow tylko na glownym poziomie '{args.katalog}'...")
        # os.listdir sprawdza tylko wskazany poziom
        for file in os.listdir(args.katalog):
            full_path = os.path.join(args.katalog, file)
            if os.path.isfile(full_path) and file.endswith(".txt"):
                if os.path.getsize(full_path) == 0:
                    print(f"Znaleziono pusty plik: {full_path}")
                    znalezione += 1

    print(f"Razem znaleziono pustych plikow: {znalezione}")


if __name__ == "__main__":
    szukaj_pustych_plikow()