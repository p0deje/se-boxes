file { 'add-public-key':
  path    => "C:/Users/${username}/.ssh/authorized_keys",
  content => file('C:/vagrant/keys/id_rsa.pub'),
}
