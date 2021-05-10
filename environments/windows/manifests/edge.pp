exec { "install-microsoft-webdriver-on-demand":
  command => "cmd /c \"DISM.exe /Online /Add-Capability /CapabilityName:Microsoft.WebDriver~~~~0.0.1.0\"",
  onlyif  => "cmd /c \"DISM.exe /Online /Get-CapabilityInfo /CapabilityName:Microsoft.WebDriver~~~~0.0.1.0 | find \"State: Not Present\"\"",
  path    => $os['windows']['system32'],
}
