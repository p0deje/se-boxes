package { 'bazelisk':
  ensure   => latest,
  provider => 'chocolatey',
  require => Package['msys2'],
}

package { 'msys2':
  ensure   => latest,
  provider => 'chocolatey',
}

windows_path { 'msys2-bin':
  ensure    => present,
  directory => 'C:\tools\msys64\usr\bin',
  require   => Package['msys2'],
}
