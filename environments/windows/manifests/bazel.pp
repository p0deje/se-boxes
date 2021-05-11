# Bazelisk might require some additional dependencies and
# doesn't provide with bazel command, so let's avoid it for now.
package { 'bazel':
  ensure   => '4.0.0',
  provider => 'chocolatey',
  require  => Package['msys2'],
}

package { 'msys2':
  ensure   => latest,
  provider => 'chocolatey',
}

windows_path { 'msys2-bin':
  ensure    => present,
  directory => 'C:\tools\msys64\usr\bin',
  require   => Package['msys2'],
}
