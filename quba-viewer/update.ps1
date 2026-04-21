Import-Module au

$change_log_url = 'https://github.com/ZUGFeRD/quba-viewer/tags'
$url_part1 = 'https://github.com/ZUGFeRD/quba-viewer/releases/download/v'
$url_part3_64 = '.msi'

function global:au_BeforeUpdate() {
     $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64
  }
function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $change_log_url
    $regex_version = '>v\d\.\d\.\d<'
    #$regex_version = '3\.3\.3 \(\d{3,4}\)'
    $versions = ([regex]$regex_version).Matches($download_page.Content)
    $most_recent_version = [String]$versions[0]
    $version = $most_recent_version.split()[0].Replace("v", "").Replace("<", "").Replace(">", "")
    $url64= $url_part1 + "${version}/Quba.${version}" + $url_part3_64
    return @{  
        URL64 = $url64
        Version = $version
    }
}
function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}
update -ChecksumFor none
