class sr-live {

  # Dependencies of sr-live
  package { [ "live-build", "atftpd", "syslinux", "nfs-kernel-server", "nfs-common" ]:
    ensure => latest,
  }

  service { "nfs-common":
    ensure  => "running",
    enable  => "true",
    require => Package["nfs-common"],
  }

  service { "nfs-kernel-server":
    ensure  => "running",
    enable  => "true",
    require => Package["nfs-kernel-server"],
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

  file { "/etc/default/nfs-common":
    ensure => 'link',
    target => "/usr/share/sr-live-image/core/system-config/nfs-common.sr",
    require => Vcsrepo[ "/usr/share/sr-live-image/" ],
    notify => Service[ "nfs-common"],
  }

  file { "/etc/default/nfs-kernel-server":
    ensure => 'link',
    target => "/usr/share/sr-live-image/core/system-config/nfs-kernel-server.sr",
    require => Vcsrepo[ "/usr/share/sr-live-image/" ],
    notify => Service[ "nfs-kernel-server"],
  }

  exec { "/usr/local/bin/sr-live-init":
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    creates => "/srv/tftp/config/common.cfg",
    require => [ Vcsrepo[ "/usr/share/sr-live-image/" ], Package["nfs-kernel-server"], Package["atftpd"] ],
  }

}
