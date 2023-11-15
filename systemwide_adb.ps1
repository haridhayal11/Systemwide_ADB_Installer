# --- security check --- #
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$host.ui.RawUI.WindowTitle = 'ADB SYSTEM INSTALLER by Haridhayal'

# --- variables --- #
$DownloadDestinationADB = "$HOME\platform-tools-latest-windows.zip"
$UnzipDestinationADB = "$HOME\platform-tools-latest-windows"
$url = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
[string]$sourceDirectory = "$HOME\ADB"
[string]$sourceDirectory = "$HOME\platform-tools-latest-windows\platform-tools\"
[string]$destinationDirectory = "$HOME\ADB"
$RemoveADBFiles = "$HOME\platform-tools-latest-windows.zip", "$HOME\platform-tools-latest-windows"

# --- download adb --- #
write-host "Downloading ADB"
Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $DownloadDestinationADB

# --- unzip adb download and move it to desired location --- #
Write-Host "Unzipping and Copying"
Expand-Archive -Path $DownloadDestinationADB -DestinationPath $UnzipDestinationADB 
Remove-item $destinationDirectory -Recurse -Force -ErrorAction SilentlyContinue
Copy-item -Force -Recurse $sourceDirectory -Destination $destinationDirectory

# --- cleanup adb download files --- #
Write-Host "Cleaning up"
Remove-Item $RemoveADBFiles -Recurse -Force

# --- set adb environment variable --- #
[Environment]::SetEnvironmentVariable("PATH", "$ENV:PATH;$destinationDirectory", "MACHINE")

# --- complete message --- #
Write-Host " "
Write-Host " "
Write-Host "Completed Installing ADB systemwide" -ForegroundColor Green
Write-Host " "
Write-Host " "
Write-Host "Launch Windows Terminal/Powershell/Command Prompt to use ADB"
Write-Host " "
