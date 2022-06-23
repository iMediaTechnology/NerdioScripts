#description: Installs the SentinelOne EDR client on the target system
#execution mode: Unknown
#tags: iMedia Technology
<#
Notes: 
Does not automatically assign a site key, will need to be entered when running
#>

#Create Directory if it doesn't already exist
#C:\LocalApps\iMT\
New-Item -Path "c:\" -Name "LocalApps" -ItemType "directory" -Verbose -ErrorAction SilentlyContinue
New-Item -Path "c:\LocalApps" -Name "iMT" -ItemType "directory" -Verbose -ErrorAction SilentlyContinue

if (Get-Variable -Name ADUsername -ErrorAction SilentlyContinue)
{
    #Download SentinelOne Installer
    Write-Host "Downloading SentinelOne Installer for $ADUsername..."
    Invoke-WebRequest -Uri "https://github.com/iMediaTechnology/NerdioScripts/releases/download/DL/SentinelOneInstaller.exe" -OutFile "c:\LocalApps\iMT\SentinelOneInstaller.exe"

    #Launch Installer Just Downloaded
    Write-Host "Installing SentinelOne Agent for $ADUsername..."
    Start-Process "c:\LocalApps\iMT\SentinelOneInstaller.exe /SILENT"
}
else
{
    Write-Error -Message "Error: Variable ADUsername was not passed to the script for evaluation."
}
