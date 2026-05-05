Import-Module au

$change_log_url = 'https://github.com/OpenVoxProject/openvox/tags'
$url_part1 = 'https://downloads.voxpupuli.org/windows/openvox'

#$url_part1 = 'https://downloads.voxpupuli.org/windows/openvox8/openvox-agent-8.25.0-x64.msi'
$url_part3_64 = '-x64.msi'

function global:au_BeforeUpdate() {
     $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64
  }
function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $change_log_url
    $regex_version = '>\d{1,2}\.\d{1,2}\.\d{1,2}<'
    $versions = ([regex]$regex_version).Matches($download_page.Content)
    $most_recent_version = [String]$versions[0]
    $version = $most_recent_version.split()[0].Replace("<", "").Replace(">", "")
    $major_version = $version.split(".")[0]
    $url64= $url_part1 + "${major_version}/openvox-agent-${version}" + $url_part3_64
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
