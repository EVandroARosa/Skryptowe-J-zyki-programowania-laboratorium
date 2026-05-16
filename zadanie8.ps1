param (
    [Parameter(Mandatory=$true)]
    [string]$h,
    [switch]$w,
    [string]$f
)

if ($w -and [string]::IsNullOrEmpty($f))
{
    Write-Error "Blad: Uzywajac opcji -w musisz podac nazwe pliku uzywajac opcji -f."
    exit 1
}

Write-Host "Testowanie polaczenia z hostem: $h..." -ForegroundColor Cyan
$pakiety = 4
$odebrane = 0
$bledy = 0

for ($i = 1; $i -le $pakiety; $i++) {
    # Test-Connection zwraca stan połączenia (cicho, bez wyrzucania błędów na ekran)
    if (Test-Connection -ComputerName $h -Count 1 -Quiet) {
        $odebrane++
    } else {
        $bledy++
    }
    Start-Sleep -Milliseconds 250
}

$procentOdebranych = ($odebrane / $pakiety) * 100

if ($procentOdebranych -eq 100) {
    $komunikat = "komunikacja sprawna (100% odebranych)"
} elseif ($procentOdebranych -gt 0) {
    $komunikat = "komunikacja z przerwami (odebranych >0 <100)"
} else {
    $komunikat = "komunikacja niemozliwa (odebranych 0%)"
}

$podsumowanie = @"
--- PODSUMOWANIE RUCHU DLA HOSTA: $h ---
Wyslano pakietow: $pakiety
Odebrano pakietow: $odebrane
Ilosc bledow: $bledy
Status: $komunikat
"@

Write-Host $podsumowanie -ForegroundColor Green

if ($w) {
    $podsumowanie | Out-File -FilePath $f -Encoding utf8
    Write-Host "Podsumowanie zostalo zapisane do pliku: $f" -ForegroundColor Gray
}