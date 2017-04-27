package { 'firefox':
  ensure   => $firefox_version,
  provider => 'chocolatey',
}

package { 'selenium-gecko-driver':
  ensure   => $geckodriver_version,
  provider => 'chocolatey',
}

windows_path { 'add-geckodriver':
  ensure    => present,
  directory => 'C:\tools\selenium',
  require   => Package['selenium-gecko-driver'],
}
