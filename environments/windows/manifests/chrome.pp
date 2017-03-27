package { 'googlechrome':
  ensure   => $chrome_version,
  provider => 'chocolatey',
}

package { 'chromedriver':
  ensure   => $chromedriver_version,
  provider => 'chocolatey',
}
