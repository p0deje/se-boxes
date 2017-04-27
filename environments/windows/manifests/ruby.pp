package { 'ruby':
  ensure   => '2.3.1',
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
  command => 'gem.bat install bundler',
  path    => 'C:/tools/ruby23/bin',
  require => [Package['ruby'], Exec['update-rubygems']],
}

# Update RubyGems to avoid SSL certificate error.
# It should not be needed once Ruby 2.3.3 is available in Chocolatey.
# See ferventcoder/chocolatey-packages#238.

file { 'downloads-dir':
  path   => 'C:\puppet-downloads',
  ensure => directory,
}

pget { 'download-rubygems-update':
  source  => 'https://rubygems.org/gems/rubygems-update-2.6.11.gem',
  target  => 'C:/puppet-downloads',
  require => File['downloads-dir'],
}

exec { 'install-rubygems-update':
  command => 'gem.cmd install --local rubygems-update-2.6.11.gem',
  path    => 'C:/tools/ruby23/bin',
  creates => 'C:/tools/ruby23/bin/update_rubygems.bat',
  cwd     => 'C:/puppet-downloads',
  require => Pget['download-rubygems-update'],
}

exec { 'update-rubygems':
  command => 'update_rubygems.bat',
  path    => 'C:/tools/ruby23/bin',
  require => Exec['install-rubygems-update'],
}
