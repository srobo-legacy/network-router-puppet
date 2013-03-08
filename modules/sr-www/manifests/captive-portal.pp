class sr-www::captive-portal($git_root){

  file{ "/etc/sr-captive-portal":
    ensure => "directory",
    owner => "root",
    mode => "755",
  }

  # Maintain a checkout of the external auth system
  vcsrepo { "/opt/sr/captive-portal":
    ensure => present,
    user => 'root',
    provider => git,
    source => "${git_root}/network/router/captive-portal.git",
    revision => "origin/master",
    force => true,
    require => [ Package[ "php5" ], File["/opt/sr"] ],
  }

  exec{ "/usr/share/sr-external-auth/client/mkkeypair.sh /etc/sr-captive-portal/key":
    require => [ File["/etc/sr-captive-portal/"], File["/usr/local/bin/create-sso-keypair"] ],
    creates => "/etc/sr-captive-portal/key",
  }

  # Symlink the captive portal files into place
  file{ "/usr/share/sr-captive-portal":
    ensure => "link",
    target => "/opt/sr/captive-portal/files/usr/share/sr-captive-portal",
  }

  file{ "/usr/share/sr-captive-portal/data":
    ensure => "directory",
    mode => "770",
    owner => "www-data",
    group => "sr-portal-admins",
    require => Group["sr-portal-admins"],
  }

  # Symlink the captive portal binaries in the right place
  file{ "/usr/bin/sr-portal-grant":
    ensure => "link",
    target => "/opt/sr/captive-portal/files/usr/bin/sr-portal-grant",
  }
  file{ "/usr/bin/sr-portal-revoke":
    ensure => "link",
    target => "/opt/sr/captive-portal/files/usr/bin/sr-portal-revoke",
  }
  file{ "/usr/bin/sr-portal-status":
    ensure => "link",
    target => "/opt/sr/captive-portal/files/usr/bin/sr-portal-status",
  }
}
