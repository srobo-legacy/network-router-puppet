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

  file { "/usr/local/sbin/dns-init":
    ensure => "present",
    source => "puppet:///modules/sr-router/dns-init",
    require => Package["bind9"],
    mode => 700,
    owner => 'root',
    group => 'root',
  }

  exec { "/usr/local/sbin/dns-init":
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => "/etc/bind/db.net.studentrobotics.org",
    notify => Service["bind9"],
    require => Group["sr-dnsadmins"],
  }

  service { "bind9":
    ensure => "running",
    enable => true,
  }
}
