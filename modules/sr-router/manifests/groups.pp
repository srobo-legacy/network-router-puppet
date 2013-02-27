class sr-router::groups {

  group { "sr-sysadmins":
    ensure => present
  }

  group { "sr-dbadmins":
    ensure => present
  }

  group { "sr-dnsadmins":
    ensure => present
  }

  group { "sr-dhcpadmins":
    ensure => present
  }

  group { "sr-portaladmins":
    ensure => present
  }

  group { "sr-videoadmins":
    ensure => present
  }

  group { "sr-compnetadmins":
    ensure => present
  }

}
