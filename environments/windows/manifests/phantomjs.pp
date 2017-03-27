package { 'phantomjs':
  ensure   => $phantomjs_version,
  provider => 'chocolatey',
}
