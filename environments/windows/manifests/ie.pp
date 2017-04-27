windows_path { 'use-prebuilt-IEDriverServer':
  ensure    => present,
  directory => 'C:\selenium\cpp\prebuilt\Win32\Release',
}

exec { 'disable-protected-mode-for-intranet-zone':
  command => 'reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "2500" /t REG_DWORD /d 3 /f',
  unless  => 'cmd /c "reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "2500" | find "0x3""',
  path    => $os['windows']['system32'],
}

exec { 'disable-protected-mode-for-trusted-zone':
  command => 'reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2500" /t REG_DWORD /d 3 /f',
  unless  => 'cmd /c "reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2500" | find "0x3""',
  path    => $os['windows']['system32'],
}

exec { 'disable-protected-mode-for-internet-zone':
  command => 'reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "2500" /t REG_DWORD /d 3 /f',
  unless  => 'cmd /c "reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "2500" | find "0x3""',
  path    => $os['windows']['system32'],
}

exec { 'disable-protected-mode-for-restricted-zone':
  command => 'reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v "2500" /t REG_DWORD /d 3 /f',
  unless  => 'cmd /c "reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v "2500" | find "0x3""',
  path    => $os['windows']['system32'],
}
