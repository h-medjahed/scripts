# This is a  PowerShell script , to install chocolatey, The package manager for Windows
# Chocolatey builds on technologies you know - unattended installation and PowerShell.
# Chocolatey works with all existing software installation technologies like MSI, NSIS,
# InnoSetup, etc, but also works with runtime binaries and zip archives.
# Example of installinf tomcat7 server with chocolatey
# Written by Hamid MEDJAHED

Set-ExecutionPolicy Unrestricted

# Log file
[string]$fileName = "tomcatinstalllog"
[string]$logfile = $CurrentDir + '\\' + $fileName + '.log'

# WritetoLog
function Write-toLog {
	[cmdletbinding()]
	param (
		[Parameter(Mandatory=$true)][string]$logMessage
	) 
	$date = Get-Date
	$logMessage2 = "> " + $date + " : User : " + $CurrentUser + " : Action : " + $logMessage
	Add-Content $logfile $logMessage2
	Write-Output $logMessage2
}

#Install chocolatey
Write-toLog -logMessage "install chocolatey"
$chocourl="https://chocolatey.org/install.ps1"
icm $executioncontext.InvokeCommand.NewScriptBlock((New-Object Net.WebClient).DownloadString($chocourl))

Write-toLog -logMessage "choco install tomcat -version 7.0.59"
Invoke-Expression("choco install tomcat -version 7.0.59 -y")
