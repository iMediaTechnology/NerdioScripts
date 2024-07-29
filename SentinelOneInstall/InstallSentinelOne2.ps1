#description: Installs the SentinelOne EDR client on the target system
#execution mode: Unknown
#tags: iMedia Technology
<#
Notes: 
Site Token stored as variable through Nerdio, accessible as $SecureVars.SentinelSiteToken
#>

#Create Directory if it doesn't already exist
#C:\LocalApps\iMT\
New-Item -Path "c:\" -Name "LocalApps" -ItemType "directory" -Verbose -ErrorAction SilentlyContinue
New-Item -Path "c:\LocalApps" -Name "iMT" -ItemType "directory" -Verbose -ErrorAction SilentlyContinue

if ($SecureVars.SentinelSiteToken)
{
    #Download SentinelOne Installer
    Write-Host "Downloading SentinelOne Installer for $ADUsername ..."
    curl -H 'Authorization: token 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' \
     -H 'Accept: application/vnd.github.v3.raw' \
     -O \
     -L "https://github.com/iMediaTechnology/NerdioScripts/releases/download/DL/SentinelOneInstaller64.exe" -OutFile "c:\LocalApps\iMT\SentinelOneInstaller.exe"

    #Launch Installer Just Downloaded
    Write-Host "Installing SentinelOne With Site Token $($SecureVars.SentinelSiteToken) ..."
    Start-Process "c:\LocalApps\iMT\SentinelOneInstaller.exe" -ArgumentList "--dont_fail_on_config_preserving_failures -q -t $($SecureVars.SentinelSiteToken)"
}
else
{
    Write-Error -Message "Error: Variable for Sentinel One site token not specified in Nerdio settings."
}
