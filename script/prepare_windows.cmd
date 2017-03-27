echo 'Ensuring Chocolatey is installed'
@powershell -NoProfile -ExecutionPolicy Bypass -File "c:\vagrant\script\install_chocolatey.ps1"

echo 'Ensuring Puppet is installed'
choco install -y puppet-agent
