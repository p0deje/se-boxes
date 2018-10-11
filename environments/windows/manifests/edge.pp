$versions = {
  '15063' => 'https://download.microsoft.com/download/3/4/2/342316D7-EBE0-4F10-ABA2-AE8E0CDF36DD/MicrosoftWebDriver.exe',
  '16299' => 'https://download.microsoft.com/download/D/4/1/D417998A-58EE-4EFE-A7CC-39EF9E020768/MicrosoftWebDriver.exe',
  '17134' => 'https://download.microsoft.com/download/F/8/A/F8AF50AB-3C3A-4BC4-8773-DC27B32988DD/MicrosoftWebDriver.exe',
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
