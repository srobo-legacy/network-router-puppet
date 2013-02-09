class sr-site::interfaces {
  file { '/etc/network/interfaces':
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '644',
    content => template('sr-site/interfaces.erb')
  }
}
