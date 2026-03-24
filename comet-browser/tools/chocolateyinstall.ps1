$ErrorActionPreference = 'Stop';

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    filetype      = 'EXE'

    # Attention: There are no download URLs with the version number and auto-updates can not be disabled
    url64         = 'https://www.perplexity.ai/rest/browser/download?platform=win_x64&channel=stable'
    checksum64    = 'F2C3C519C349291D9106693034883F7C74B7F26C42C88637DE8C17A426106DC8'
    checksumType64= 'sha256'
    silentArgs    = '--do-not-launch-chrome --system-level --verbose-logging'
}

Install-ChocolateyPackage @packageArgs
