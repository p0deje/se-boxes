class {'apt': always_apt_update => true}

package {'build-essential':}

class {'rbenv':}
rbenv::plugin {'sstephenson/ruby-build':}
rbenv::build {'2.1.2': global => true}

class {'display':}
class {'firefox': version => "${firefox_version}.0-0ubuntu1"}
