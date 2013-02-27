class bee {

  file { "/etc/motd.tail":
    mode => 444,
    owner => root,
    group => root,
    source => "puppet:///modules/bee/motd",
  }

}
