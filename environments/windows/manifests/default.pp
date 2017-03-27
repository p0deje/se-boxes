package { 'curl':
  ensure   => present,
  provider => 'chocolatey',
}

package { 'git':
  ensure   => present,
  provider => 'chocolatey',
}

package { 'conemu':
  ensure   => present,
  provider => 'chocolatey',
}
