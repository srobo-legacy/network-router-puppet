class sr-router::sudo {
  package { "sudo":
    ensure => "latest",
  }

  file { "/etc/sudoers":
    ensure => "present",
    content => template("sr-router/sudoers"),
    mode => "440",
    owner => "root",
    group => "root",
  }
}
