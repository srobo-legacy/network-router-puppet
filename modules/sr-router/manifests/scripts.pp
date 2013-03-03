class sr-router::scripts{

  # Maintain a checkout of the external auth system
  vcsrepo { "/opt/sr/router-scripts":
    ensure => present,
    user => 'root',
    provider => git,
    source => "https://github.com/cjsoftuk/sr-router-scripts.git",
    revision => "origin/master",
    force => true,
    require => [ Package[ "php5" ], File["/opt/sr"] ],
  }

  # DHCP host library
  file{ "/usr/share/php/SR_DHCP_Host.php":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/share/php/SR_DHCP_Host.php",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }

  # Symlink the captive portal binaries in the right place
  file{ "/usr/bin/sr-dhcp-register":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/bin/sr-dhcp-register",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }
  file{ "/usr/bin/sr-dhcp-unregister":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/bin/sr-dhcp-unregister",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }
  file{ "/usr/bin/sr-dhcp-getip":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/bin/sr-dhcp-getip",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }
  file{ "/usr/bin/sr-dhcp-competitor-register":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/bin/sr-dhcp-competitor-register",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }
  file{ "/usr/bin/sr-dhcp-competitor-unregister":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/bin/sr-dhcp-competitor-unregister",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }
  file{ "/usr/bin/sr-dns-register":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/bin/sr-dns-register",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }
  file{ "/usr/bin/sr-dns-unregister":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/bin/sr-dns-unregister",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }
  file{ "/usr/bin/sr-net-add-device":
    ensure => "link",
    target => "/opt/sr/router-scripts/files/usr/bin/sr-net-add-device",
    require => Vcsrepo["/opt/sr/router-scripts"],
  }
}
