package { 'firefox':
  ensure   => $firefox_version,
  provider => 'chocolatey',
}

package { 'selenium-gecko-driver':
  ensure   => $geckodriver_version,
  provider => 'chocolatey',
}
