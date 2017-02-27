# This is a  PowerShell script , to install chocolatey, The package manager for Windows
# Chocolatey builds on technologies you know - unattended installation and PowerShell.
# Chocolatey works with all existing software installation technologies like MSI, NSIS,
# InnoSetup, etc, but also works with runtime binaries and zip archives.
# Written by Hamid MEDJAHED

Set-ExecutionPolicy Unrestricted
#Install chocolatey 
$chocourl="https://chocolatey.org/install.ps1"
icm $executioncontext.InvokeCommand.NewScriptBlock((New-Object Net.WebClient).DownloadString($chocourl))
# Example using chocolatey to install notepad++
# Invoke-Expression("choco install notepadplusplus.install -y")
