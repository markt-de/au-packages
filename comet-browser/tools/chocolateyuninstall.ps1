$ErrorActionPreference = 'SilentlyContinue'

# ------------------------------------------------------------
# 1. Kill active comet process
# ------------------------------------------------------------

Get-Process -Name comet*, chrome* -ErrorAction SilentlyContinue | Stop-Process -Force

# ------------------------------------------------------------
# 2. Uninstall-String on registry
# ------------------------------------------------------------

$regPaths = @(
	'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
	'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

$app = Get-ItemProperty $regPaths |
	Where-Object { $_.DisplayName -match 'Comet' } |
	Select-Object -First 1

if (-not $app) {
	Write-Host "Comet not found"
	exit 0
}

# ------------------------------------------------------------
# 3. Silent-Uninstall with chrome flags
# ------------------------------------------------------------

$cmd = $app.UninstallString.Trim()

$uninstallExe = ""
$uninstallArgs = ""


if ($cmd.StartsWith('"')) {
	$parts = $cmd.Split('"')
	$uninstallExe = $parts[1]
	$uninstallArgs = ($parts[2]).Trim()
}
else {
	$parts = $cmd.Split(' ', 2)
	$uninstallExe = $parts[0]
	if ($parts.Count -gt 1){
		$uninstallArgs = $parts[1]
	}
}

$finalArgs = "$uninstallArgs --force-uninstall --system-level --delete-profile --do-not-launch-chrome"

# ------------------------------------------------------------
# 4. Start silent uninstall
# ------------------------------------------------------------

if (Test-Path $uninstallExe) {
	Start-Process -FilePath $uninstallExe -ArgumentList $finalArgs -WindowStyle Hidden -Wait 
}
else {
	Write-Host "uninstaller nicht gefunden: $uninstallExe"
}

Start-Sleep -Seconds 5

exit 0
