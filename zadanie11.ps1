param (
    [Parameter(Mandatory=$true)]
    [string]$Katalog,
    [switch]$s
)

if (-not (Test-Path -Path $Katalog -PathType Container)) {
    Write-Error "Blad: Podany katalog '$Katalog' nie istnieje."
    exit 1
}

if ($s) {
    Write-Host "Analizuje pliki .txt w katalogu i podkatalogach..." -ForegroundColor Cyan
    $pliki = Get-ChildItem -Path $Katalog -Filter "*.txt" -Recurse
} else {
    Write-Host "Analizuje pliki .txt tylko w wybranym katalogu..." -ForegroundColor Cyan
    $pliki = Get-ChildItem -Path $Katalog -Filter "*.txt"
}

foreach ($plik in $pliki) {
    if ($plik -is [System.IO.FileInfo]) {
        # Get-Content wczytuje plik jako tablicę linii, Measure-Object je zlicza
        $iloscLinii = (Get-Content -Path $plik.FullName | Measure-Object -Line).Lines
        Write-Host "Plik: $($plik.Name) -> Linii: $iloscLinii" -ForegroundColor White
    }
}