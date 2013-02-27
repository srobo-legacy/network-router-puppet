class sr-router::dhcp {
  package{ "isc-dhcp-server":
    ensure => "present",
  }

  file { "/etc/dhcp/dhcpd.conf":
    ensure => "present",
    source => "puppet:///modules/sr-router/dhcpd.conf",
    require => Package["isc-dhcp-server"],
    notify => Service["isc-dhcp-server"],
  }

  file { "/etc/default/isc-dhcp-server":
    ensure => "present",
    source => "puppet:///modules/sr-router/dhcpd.default",
    require => Package["isc-dhcp-server"],
    notify => Service["isc-dhcp-server"],
  }

  service { "isc-dhcp-server":
    ensure => "running",
    enable => true,
  }
}
