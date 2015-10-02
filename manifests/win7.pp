package {'ruby':
  ensure   => latest,
  provider => 'chocolatey',
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
