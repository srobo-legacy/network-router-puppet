class sr-router::dhcp {
  package{ "isc-dhcp-server":
    ensure => "present",
  }

  file { "/usr/local/sbin/dhcp-init":
    ensure => "present",
    source => "puppet:///modules/sr-router/dhcp-init",
    require => Package["isc-dhcp-server"],
    mode => 700,
    owner => 'root',
    group => 'root',
  }

  exec { "/usr/local/sbin/dhcp-init 30":
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => "/etc/dhcp/sr-team-subnets.conf",
    notify => Service["isc-dhcp-server"],
    require => [ File["/usr/local/sbin/dhcp-init"], Group["sr-dhcpadmins"] ],
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
