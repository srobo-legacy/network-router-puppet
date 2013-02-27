class sr-www::apache2 {
  package { "apache2":
    ensure => latest,
  }

  service { "apache2":
    enable => true,
    ensure => running,
    subscribe => [ Package[ "apache2" ],
                 ],
  }

}
