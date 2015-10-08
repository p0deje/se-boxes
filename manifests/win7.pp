package {'ruby':
  ensure   => '2.1.6',
  provider => 'chocolatey',
}

package {'ruby2.devkit':
  ensure   => latest,
  provider => 'chocolatey',
  require  => Package['ruby'],
}

package {'python':
  ensure   => '2.7.6',
  provider => 'chocolatey',
}

package {'jdk7':
  ensure   => latest,
  provider => 'chocolatey',
}

package {'curl':
  ensure   => installed,
  provider => 'chocolatey',
}

package {'firefox':
  ensure   => $firefox_version,
  provider => 'chocolatey',
}

package {'phantomjs':
  ensure   => $phantomjs_version,
  provider => 'chocolatey',
}

package {'google-chrome-x64':
  ensure   => $chrome_version,
  provider => 'chocolatey',
}

file {'config-rubydevkit':
  path    => 'C:\tools\DevKit2\config.yml',
  content => '- C:/tools/ruby21',
  require => Package['ruby2.devkit'],
}

exec {'install-rubydevkit':
  command => 'C:\tools\ruby21\bin\ruby.exe dk.rb install',
  cwd     => 'C:\tools\DevKit2',
  require => File['config-rubydevkit'],
}
