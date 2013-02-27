class sr-www::php {

  package { [ "php5", "libapache2-mod-php5" ]:
    ensure => latest,
    notify => Service[ "apache2" ],
  }

}
