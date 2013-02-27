class sr-router::bind {
  package{ "bind9":
    ensure => "present",
  }

  file { "/etc/bind/named.conf":
    ensure => "present",
    source => "puppet:///modules/sr-router/named.conf",
    require => Package["bind9"],
    notify => Service["bind9"],
  }

  service { "bind9":
    ensure => "running",
    enable => true,
  }
}
