package { 'ruby':
  ensure   => '2.5.1.2',
  provider => 'chocolatey',
}

exec { 'install-bundler':
  command => 'gem.cmd install bundler -v 1.17.3',
  path    => 'C:/tools/ruby25/bin',
  require => Package['ruby'],
}
