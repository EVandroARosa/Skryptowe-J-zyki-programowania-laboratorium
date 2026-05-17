def rysuj_choinke():
    try:
        n = int(input("Rysujemy choinke, podaj ilosc poziomow: "))
    except ValueError:
        print("Blad: Musisz podac liczbe calkowita!")
        return

    if n <= 0:
        print("Blad: Wysokosc musi byc wieksza od zera.")
        return

    for i in range(n):
        for j in range(n - i - 1):
            print(" ", end="")
        for k in range(2 * i + 1):
            print("*", end="")
        print()

    h_pnia = max(1, int(n / 3))
    w_pnia = int(n / 5)
    if w_pnia % 2 == 0:
        w_pnia += 1
    if w_pnia < 1:
        w_pnia = 1


    spacje_pnia = n - 1 - int(w_pnia / 2)


    for i in range(h_pnia):
        for j in range(spacje_pnia):
            print(" ", end="")
        for k in range(w_pnia):
            print("*", end="")
        print()

if __name__ == "__main__":
    rysuj_choinke()