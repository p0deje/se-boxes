$versions = {
  '14393' => 'https://download.microsoft.com/download/3/2/D/32D3E464-F2EF-490F-841B-05D53C848D15/MicrosoftWebDriver.exe',
  '15063' => 'https://download.microsoft.com/download/3/4/2/342316D7-EBE0-4F10-ABA2-AE8E0CDF36DD/MicrosoftWebDriver.exe',
}

$versions.each |String $version, String $url| {
  pget { "download-microsoft-webdriver-${version}":
    source         => $url,
    target         => 'C:/tools/selenium',
    targetfilename => "MicrosoftWebDriver${version}.exe",
    require        => File['selenium-tools-dir'],
  }

  # https://github.com/cyberious/puppet-pget/issues/19
  exec { "use-microsoft-webdriver-${version}":
    command     => "cmd /c \"mklink /h MicrosoftWebDriver.exe MicrosoftWebDriver${version}.exe\"",
    onlyif      => "cmd /c \"ver | find \"${version}\"\"",
    cwd         => 'C:/tools/selenium',
    path        => $os['windows']['system32'],
    refreshonly => true,
    subscribe   => Pget["download-microsoft-webdriver-${version}"],
  }
}
