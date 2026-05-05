$packageName = 'openvox-agent'


$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url64          = 'https://downloads.voxpupuli.org/windows/openvox8/openvox-agent-8.26.2-x64.msi'
  checksum64     = 'f0804e6bf7a7331a36035c1bac615a0cdf4d868fea970fe99fa84c718d2dba77'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
