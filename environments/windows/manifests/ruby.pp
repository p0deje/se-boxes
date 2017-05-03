package { 'ruby':
  ensure   => '2.3.3',
  provider => 'chocolatey',
}

package { 'ruby2.devkit':
  ensure   => latest,
  provider => 'chocolatey',
  require  => Package['ruby'],
}

file { 'config-rubydevkit':
  path    => 'C:/tools/DevKit2/config.yml',
  content => '- C:/tools/ruby23',
  require => Package['ruby2.devkit'],
}

exec { 'install-rubydevkit':
  command => 'ruby dk.rb install',
  path    => 'C:/tools/ruby23/bin',
  cwd     => 'C:/tools/DevKit2',
  require => File['config-rubydevkit'],
}

exec { 'install-bundler':
  command => 'gem.cmd install bundler',
  path    => 'C:/tools/ruby23/bin',
  require => Package['ruby'],
}
