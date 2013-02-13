class sr-site::freeradius {
  package { 'freeradius':
    ensure => 'present',
  }
  package { 'freeradius-mysql':
    ensure => 'present',
    require => Class['sr-site::mysql'],
  }
}
