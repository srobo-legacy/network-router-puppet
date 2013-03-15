class sr-router::ntop {
    package { "ntop":
      ensure => "latest",
    }

    service { "ntop":
      ensure => "running",
      require => [ Package["ntop"], File["/etc/default/ntop"] ],
    }

    file { "/etc/default/ntop":
      source => "puppet:///modules/sr-router/ntop.default",
      owner => "root",
      group => "root",
      mode => "644",
      require => Package["ntop"],
      notify => Service["ntop"],
    }
}
