$packageName = 'openvox-agent'


$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url64          = 'https://downloads.voxpupuli.org/windows/openvox8/openvox-agent-8.28.0-x64.msi'
  checksum64     = '9590bbc135f8633992a6e16034b08e6b855e11fecb80088b52802987f1ea6f34'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
