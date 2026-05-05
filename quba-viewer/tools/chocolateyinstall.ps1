$ErrorActionPreference = 'Stop';

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    filetype      = 'MSI'

    url64         = 'https://github.com/ZUGFeRD/quba-viewer/releases/download/v1.5.1/Quba.1.5.1.msi'
    checksum64    = '61b548bebeabae42a2de01bb0cbaff6373ef52bb92cf2ee48d776d1628a8a987'
    checksumType64= 'sha256'
    silentArgs    = "/qn /norestart ALLUSERS=1 /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs
