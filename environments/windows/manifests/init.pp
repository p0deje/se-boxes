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

exec { 'enable-development-mode':
  command => 'reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"',
  unless  => 'cmd /c "reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowDevelopmentWithoutDevLicense"',
  path    => $os['windows']['system32'],
}
