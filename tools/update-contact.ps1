param(
  [Parameter(Mandatory = $true)]
  [ValidatePattern('^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')]
  [string]$Email
)
$ErrorActionPreference = 'Stop'
$projectRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
$scriptPath = Join-Path $projectRoot 'assets\js\main.js'
$scriptText = [System.IO.File]::ReadAllText($scriptPath)
$match = [regex]::Match($scriptText, "const CONTACT_EMAIL = '([^']+)';")
if (-not $match.Success) { throw 'CONTACT_EMAIL constant was not found.' }
$oldEmail = $match.Groups[1].Value
$utf8 = New-Object System.Text.UTF8Encoding($false)
$files = @(Get-ChildItem -LiteralPath $projectRoot -Filter '*.html' -Recurse)
foreach ($file in $files) {
  $text = [System.IO.File]::ReadAllText($file.FullName)
  [System.IO.File]::WriteAllText($file.FullName, $text.Replace($oldEmail, $Email), $utf8)
}
[System.IO.File]::WriteAllText($scriptPath, $scriptText.Replace($oldEmail, $Email), $utf8)
Write-Output "Updated CONTACT_EMAIL and static HTML fallbacks to $Email"
