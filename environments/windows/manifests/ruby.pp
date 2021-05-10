package { 'ruby':
  ensure   => '2.6.5.1',
  provider => 'chocolatey',
}

exec { 'install-bundler':
  command => 'gem.cmd install bundler -v 2.1.4',
  path    => 'C:/tools/ruby26/bin',
  require => Package['ruby'],
}
