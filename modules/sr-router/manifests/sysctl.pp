class sr-router::sysctl {
  file { "/etc/sysctl.d/sr.conf":
    ensure => "present",
    source => "puppet:///modules/sr-router/sysctl.conf",
  }
  exec { "/sbin/sysctl -p":
    require => File["/etc/sysctl.d/sr.conf"],
  }
}
