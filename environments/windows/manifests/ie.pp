windows_path { 'use-prebuilt-IEDriverServer':
  ensure    => present,
  directory => 'C:\selenium\cpp\prebuilt\x64\Release',
}
