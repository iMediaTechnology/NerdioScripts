#description: Installs the ScreenConnect/Connectwise Control client on the target system
#execution mode: Unknown
#tags: iMedia Technology
<#
Notes: 
This script adds the user assigned the personal desktop to the local admin group
#>

param(
    [Parameter()]
    [String]$clientName
)

#Create Directory if it doesn't already exist
#C:\LocalApps\iMT\
New-Item -Path "c:\" -Name "LocalApps" -ItemType "directory" -Verbose -ErrorAction SilentlyContinue
New-Item -Path "c:\LocalApps" -Name "iMT" -ItemType "directory" -Verbose -ErrorAction SilentlyContinue

if ($clientName -ne "")
{
    #Download ScreenConnect Installer
    Write-Host "Downloading SC Installer for $clientName..."
    Invoke-WebRequest -Uri "https://imedia.screenconnect.com/Bin/ConnectWiseControl.ClientSetup.exe?h=instance-wj4gej-relay.screenconnect.com&p=443&k=BgIAAACkAABSU0ExAAgAAAEAAQBNOXNavuhdZkfi5aTRPinXizVPaZwvD7LRtzB%2ByoEfJ4STxUDOPuO6SFQBb19bElca9%2FKkrGCNyPsOaxwXDRt66JR2H6VfuwNYYYWYws1TUJS0sXZyfwI6LBXYVg8WQb0vV3FJ1Kg1kgXrCe9WetSA8uWysI%2FtHWEEZeMvbgOT58HXW%2Bi6WEJWp3LTPUcFf7%2F4NQ4do4gYejPilEzK8OOu1HdpLOAoUCGMYnDGqDEap%2BMMBPa8mHp%2BxZ%2FXukDDsbqzzyRcuNcjdDglVYzdEW%2FTet6miTDpxtZdn%2BoM%2Bw1nIndK%2BmTojItGwIQSpGsA%2B%2BUa0UlfHLBl58L2SshF0fu%2F&e=Access&y=Guest&t=&c=$clientName&c=&c=&c=&c=&c=&c=&c=" -OutFile "c:\LocalApps\iMT\ScreenConnectInstaller.exe"

    #Launch Installer Just Downloaded
    Write-Host "Installing SC Client for $clientName..."
    Start-Process "c:\LocalApps\iMT\ScreenConnectInstaller.exe"
}
else
{
    Write-Error -Message "Error: Please specify the client group as a parameter."
}
