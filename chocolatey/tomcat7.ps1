cls
Set-ExecutionPolicy Unrestricted

[string]$Depot = "https://raw.githubusercontent.com/jewelro/PSscripts/master/"
[string]$DepotChoco = "https://chocolatey.org/install.ps1"
[string]$CurrentDir = $(get-location).Path
[string]$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

# Log file
[string]$fileName = "scriptInstall"
[string]$logfile = $CurrentDir + '\\' + $fileName + '.log'

# Transcription file
[string]$transcriptPath = $CurrentDir + '\\' + $fileName + 'Transcript.txt'
Start-Transcript -Path $transcriptPath -Force -Append -NoClobber

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

# Install function
function Install-GitFile {
	[cmdletbinding()]
	param (
		[Parameter(Mandatory=$true)][string]$installFile,
		[Parameter(Mandatory=$false)][string[]]$argList
	) 
	$logmess = "install: $installFile : args : $argList"
	Write-toLog -logMessage $logmess
	if ($argList){
		icm $executioncontext.InvokeCommand.NewScriptBlock((New-Object Net.WebClient).DownloadString($installFile)) -ArgumentList $argList
	}
	else {
		icm $executioncontext.InvokeCommand.NewScriptBlock((New-Object Net.WebClient).DownloadString($installFile)) 
	}
	#wait 2 seconds 
	Start-Sleep -m 2000
}

Write-toLog -logMessage "start execution $fileName"

try {
	# install chocolatey
	$myfile = $DepotChoco
	#$myfile = $Depot + "chocoInstall.ps1"
	Install-GitFile -installFile $myfile

	# install Tomcat 7
	Write-toLog -logMessage "choco install tomcat -version 7.0.59"
	Invoke-Expression("choco install tomcat -version 7.0.59 -y")

	# Exit
	Write-toLog -logMessage "end execution $fileName"
	stop-transcript
}
catch {
  Write-Output "EXCEPTION : "
  $ErrorMessage = $_.Exception.Message
  $FailedItem = $_.Exception.ItemName
  Write-toLog -logMessage $ErrorMessage
  stop-transcript
  Throw $_.Exception
}
