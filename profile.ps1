Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)
Import-Module .\posh-git

function Test-Administrator {
	$user = [Security.Principal.WindowsIdentity]::GetCurrent();
	(New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function global:prompt {
	$origLastExitCode = $LASTEXITCODE
 
	if (Test-Administrator) {
		Write-Host "(Elevated) " -NoNewline -ForegroundColor White
	}

	Write-Host "$ENV:USERNAME@" -NoNewline -ForegroundColor DarkYellow
	Write-Host "$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Magenta

	if ($s -ne $null) {
		Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
		Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
		Write-Host ") " -NoNewline -ForegroundColor DarkGray
	}
	
	Write-Host " : " -NoNewline -ForegroundColor DarkGray
	Write-Host $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~") -NoNewline -ForegroundColor Blue
	Write-Host " : " -NoNewline -ForegroundColor DarkGray
	Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta
	Write-Host " : " -NoNewline -ForegroundColor DarkGray

	$global:LASTEXITCODE = $realLASTEXITCODE

	Write-VcsStatus

	Write-Host ""
	
	return "> "
}

Pop-Location

Start-SshAgent -Quiet
