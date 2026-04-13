import-module au

$url_base       = 'https://www.perplexity.ai/rest/browser/download?platform=win_x64&channel=stable&version='
$change_log_url = 'https://www.perplexity.ai/changelog'
$releases       = 'https://github.com/microsoft/winget-pkgs/tree/master/manifests/p/Perplexity/'

function global:au_BeforeUpdate() {
     $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64
}

function global:au_SearchReplace {
   @{
        '.\tools\chocolateyInstall.ps1' = @{
            "(?i)(^\s*url64\s*=\s*)('.*')"       = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {

  $regex_version='v(\d{1,2}\.\d{1,2}\.\d{1,3})'
  $content=(Invoke-WebRequest -UseBasicParsing -Uri $releases).content
  $matches=[regex]::Matches($content, $regex_version)
  
  $most_recent_version_temp = $matches[0] -replace ".$"
  $version = $most_recent_version_temp -replace "^."   
    @{
        URL64   = $url_base
        Version = $version
    }
}

update -ChecksumFor none