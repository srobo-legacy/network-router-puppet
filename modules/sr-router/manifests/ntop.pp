class sr-router::ntop {
    package { "ntop":
      ensure => "latest",
    }

    service { "ntop":
      ensure => "running",
      require => [ Package["ntop"], File["/etc/default/ntop"], File["/var/lib/ntop/init.cfg"] ],
    }

    file { "/etc/default/ntop":
      source => "puppet:///modules/sr-router/ntop.default",
      owner => "root",
      group => "root",
      mode => "644",
      require => Package["ntop"],
      notify => Service["ntop"],
    }

    file { "/var/lib/ntop/init.cfg":
      source => "puppet:///modules/sr-router/ntop.cfg",
      owner => "root",
      group => "root",
      mode => "644",
      require => Package["ntop"],
      notify => Service["ntop"],
    }
}
