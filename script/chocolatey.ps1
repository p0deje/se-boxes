if (!(Test-Path "$env:SystemDrive\ProgramData\Chocolatey\bin")) {
  # Install chocolatey
  Write-Host "Chocolatey is not installed. Proceeding."
  (iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')))>$null 2>&1
} else {
  Write-Host "Chocolatey is installed. Upgrading."
  choco upgrade chocolatey -y
}
