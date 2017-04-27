file { 'tools-dir':
  path   => 'C:\tools',
  ensure => directory,
}

file { 'selenium-tools-dir':
  path    => 'C:\tools\selenium',
  ensure  => directory,
  require => File['tools-dir'],
}

windows_path { 'selenium-tools-dir':
  ensure    => present,
  directory => 'C:\tools\selenium',
  require   => File['selenium-tools-dir'],
}
