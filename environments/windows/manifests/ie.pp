windows_path { 'use-prebuilt-IEDriverServer':
  ensure    => present,
  directory => 'C:\selenium\cpp\prebuilt\Win32\Release',
}
