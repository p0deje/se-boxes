package { 'ruby':
  ensure   => '2.5.1.2',
  provider => 'chocolatey',
}

exec { 'install-bundler':
  command => 'gem.cmd install bundler',
  path    => 'C:/tools/ruby25/bin',
  require => Package['ruby'],
}
