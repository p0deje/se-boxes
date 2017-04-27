package { 'ruby':
  ensure   => '2.3.1',
  provider => 'chocolatey',
}

package { 'ruby2.devkit':
  ensure   => latest,
  provider => 'chocolatey',
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

pget { 'download-rubygems-update':
  source => 'https://rubygems.org/gems/rubygems-update-2.6.11.gem',
  target => 'C:/Users/vagrant/Downloads',
}

exec { 'install-rubygems-update':
  command => 'gem.cmd install --local rubygems-update-2.6.11.gem',
  path    => 'C:/tools/ruby23/bin',
  creates => 'C:/tools/ruby23/bin/update_rubygems.bat',
  cwd     => 'C:/Users/vagrant/Downloads',
  require => Pget['download-rubygems-update'],
}

exec { 'update-rubygems':
  command => 'update_rubygems.bat',
  path    => 'C:/tools/ruby23/bin',
  require => Exec['install-rubygems-update'],
}

exec { 'install-bundler':
  command => 'gem.bat install bundler',
  path    => 'C:/tools/ruby23/bin',
  require => Exec['update-rubygems'],
}
