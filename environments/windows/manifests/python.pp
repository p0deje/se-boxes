package { 'python':
  ensure   => '2.7.11',
  provider => 'chocolatey',
}

exec { 'install-requests':
  command => 'pip.exe install requests',
  path    => 'C:/tools/python/Scripts',
  require => Package['python'],
}
