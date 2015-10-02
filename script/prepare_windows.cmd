echo 'Ensuring .NET 4.0 is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\script\install_dotnet40.ps1"

:: Puppet chocolatey module should be able to install itself,
:: but for some reason it does not work.
echo 'Ensuring Chocolatey is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\script\install_chocolatey.ps1"

echo 'Ensuring Puppet is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\script\install_puppet.ps1"
