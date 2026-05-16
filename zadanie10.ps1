param (
    [Parameter(Mandatory=$true)]
    [string]$Katalog,
    [switch]$WszystkiePoziomy
)

if (-not (Test-Path -Path $Katalog -PathType Container))
{
    Write-Error "Blad: Podany katalog '$Katalog' nie istnieje."
    exit 1
}


if ($WszystkiePoziomy) {
    Write-Host "Szukam pustych plikow tekstowych w '$Katalog' oraz we wszystkich podkatalogach..." -ForegroundColor Cyan
    $pliki = Get-ChildItem -Path $Katalog -Filter "*.txt" -Recurse | Where-Object { $_.Length -eq 0 }
} else {
    Write-Host "Szukam pustych plikow tekstowych tylko na glownym poziomie '$Katalog'..." -ForegroundColor Cyan
    $pliki = Get-ChildItem -Path $Katalog -Filter "*.txt" | Where-Object { $_.Length -eq 0 }
}
if ($pliki) {
    foreach ($plik in $pliki) {
        Write-Host "Znaleziono pusty plik: $($plik.FullName)" -ForegroundColor Yellow
    }
    Write-Host "Razem znaleziono pustych plikow: $($pliki.Count)" -ForegroundColor Green
} else {
    Write-Host "Nie znaleziono zadnych plikow .txt o rozmiarze zero." -ForegroundColor Green
}