
Import-Module posh-git
Import-Module Get-ChildItemColor

Set-Alias l Get-ChildItem-Color -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


(@(& 'C:/Users/David/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\David\AppData\Local\Programs\oh-my-posh\themes\jandedobbeleer.omp.json' --print) -join "`n") | Invoke-Expression

