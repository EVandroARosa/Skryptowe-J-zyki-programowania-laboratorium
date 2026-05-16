param (
    [Parameter(Mandatory=$true)]
    [int]$m,
    [Parameter(Mandatory=$true)]
    [int]$n
)

$min = [Math]::Min($m, $n)
$max = [Math]::Max($m, $n)

$wylosowana = Get-Random -Minimum $min -Maximum ($max + 1)
$imie = Read-Host "Podaj swoje imie"
$proby = 0
$odgadnieta = $false

Write-Host "Wylosowalem liczbe z zakresu od $min do $max. Zgadnij jaka!" -ForegroundColor Cyan

while (-not $odgadnieta) {
    [int]$strzal = Read-Host "Tworzenie proby (Podaj liczbe)"
    $proby++

    if ($strzal -lt $wylosowana) {
        Write-Host "Za malo!" -ForegroundColor Yellow
    } elseif ($strzal -gt $wylosowana) {
        Write-Host "Za duzo!" -ForegroundColor Yellow
    } else {
        Write-Host "Gratulacje $imie! Odgadles liczbe za $proby razem!" -ForegroundColor Green
        $odgadnieta = $true
    }
}

$data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$statystyka = "Gracz: $imie | Data: $data | Zakres: $min-$max | Wynik: $proby prob"
$statystyka | Out-File -FilePath "statystyki_gry.txt" -Append
Write-Host "Statystyki zostaly zapisane do pliku statystyki_gry.txt" -ForegroundColor Gray