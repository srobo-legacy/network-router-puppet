class sr-site::mysql {
  package { 'mysql-server':
    ensure => 'present',
  }
}
