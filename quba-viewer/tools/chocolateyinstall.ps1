$ErrorActionPreference = 'Stop';

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    filetype      = 'MSI'

    url64         = 'https://github.com/ZUGFeRD/quba-viewer/releases/download/v1.5.0/Quba.1.5.0.msi'
    checksum64    = 'd8d3013518f70e9340d0f2ea97fe7af1c96bfd2f3131bd9804e19c7740e6fcbd'
    checksumType64= 'sha256'
    silentArgs    = "/qn /norestart ALLUSERS=1 /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs
