class sr-live {

  # Dependencies of sr-live
  package { [ "live-build", "atftpd", "syslinux", "nfs-kernel-server", "nfs-common" ]:
    ensure => latest,
  }

  # live-build images base configs
  vcsrepo { "/usr/share/sr-live-image/":
    ensure => present,
    user => 'root',
    provider => git,
    source => "https://github.com/cjsoftuk/sr-live-images.git",
    revision => "origin/master",
    force => true,
    require => Package[ "live-build" ],
  }

  file { "/usr/local/bin/sr-live-add":
    ensure => 'link',
    target => "/usr/share/sr-live-image/core/bin/sr-live-add",
    require => Vcsrepo[ "/usr/share/sr-live-image/" ],
  }

  file { "/usr/local/bin/sr-live-autoboot":
    ensure => 'link',
    target => "/usr/share/sr-live-image/core/bin/sr-live-autoboot",
    require => Vcsrepo[ "/usr/share/sr-live-image/" ],
  }

  file { "/usr/local/bin/sr-live-build":
    ensure => 'link',
    target => "/usr/share/sr-live-image/core/bin/sr-live-build",
    require => Vcsrepo[ "/usr/share/sr-live-image/" ],
  }

  file { "/usr/local/bin/sr-live-init":
    ensure => 'link',
    target => "/usr/share/sr-live-image/core/bin/sr-live-init",
    require => Vcsrepo[ "/usr/share/sr-live-image/" ],
  }

  exec { "/usr/local/bin/sr-live-init":
    creates => "/srv/tftp/config/common.cfg",
    require => [ Vcsrepo[ "/usr/share/sr-live-image/" ], Package["nfs-kernel-server"], Package["atftpd"] ],
  }

}
