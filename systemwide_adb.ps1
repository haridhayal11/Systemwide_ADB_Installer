if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$host.ui.RawUI.WindowTitle = 'ADB SYSTEM INSTALLER by Haridhayal'

write-host "Downloading ADB"
$DownloadDestinationADB = "$PSScriptRoot\platform-tools-latest-windows.zip"
$UnzipDestinationADB = "$PSScriptRoot\platform-tools-latest-windows"
$url = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
$start_time = Get-Date
[string]$sourceDirectory = "$PSScriptRoot\ADB"
     
Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $DownloadDestinationADB

Write-Host "Unzipping and Copying"
Expand-Archive -Path $DownloadDestinationADB -DestinationPath $UnzipDestinationADB 
[string]$sourceDirectory = "$PSScriptRoot\platform-tools-latest-windows\platform-tools\"
[string]$destinationDirectory = "$PSScriptRoot\ADB"
Remove-item $destinationDirectory -Recurse -Force -ErrorAction SilentlyContinue
Copy-item -Force -Recurse $sourceDirectory -Destination $destinationDirectory
Write-Host "Cleaning up"
$RemoveADBFiles = "$PSScriptRoot\platform-tools-latest-windows.zip", "$PSScriptRoot\platform-tools-latest-windows"
Remove-Item $RemoveADBFiles -Recurse -Force
[Environment]::SetEnvironmentVariable("PATH", "$ENV:PATH;$destinationDirectory", "MACHINE")

Write-Host "Completed Installing ADB systemwide"
Write-Host "Launch Windows Terminal/Powershell/Command Prompt to use ADB"
