$packageName = 'openvox-agent'


$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url64          = 'https://downloads.voxpupuli.org/windows/openvox8/openvox-agent-8.32.0-x64.msi'
  checksum64     = '03974860c56358954f0200dfe4be32d32d876ad6b57b85c690bc1e2542e556c6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
