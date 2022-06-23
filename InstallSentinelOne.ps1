#description: Installs the ScreenConnect/Connectwise Control client on the target system
#execution mode: Unknown
#tags: iMedia Technology
<#
Notes: 
This script adds the user assigned the personal desktop to the local admin group
#>

#Create Directory if it doesn't already exist
#C:\LocalApps\iMT\
New-Item -Path "c:\" -Name "LocalApps" -ItemType "directory" -Verbose -ErrorAction SilentlyContinue
New-Item -Path "c:\LocalApps" -Name "iMT" -ItemType "directory" -Verbose -ErrorAction SilentlyContinue

if (Get-Variable -Name ADUsername -ErrorAction SilentlyContinue)
{
    #Download SentinelOne Installer
    Write-Host "Downloading SentinelOne Installer for $ADUsername..."
    Invoke-WebRequest -Uri "https://usea1-pax8-exsp.sentinelone.net/web/api/v2.1/update/agent/download/1448672912175077832/1444005816764352097" -OutFile "c:\LocalApps\iMT\SentinelOneInstaller.exe"

    #Launch Installer Just Downloaded
    Write-Host "Installing SentinelOne Agent for $ADUsername..."
    Start-Process "c:\LocalApps\iMT\SentinelOneInstaller.exe /SILENT"
}
else
{
    Write-Error -Message "Error: Variable ADUsername was not passed to the script for evaluation."
}
