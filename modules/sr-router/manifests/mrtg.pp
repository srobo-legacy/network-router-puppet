class sr-router::mrtg {

  package{ ["mrtg", "snmp", "snmpd"]:
    ensure => "latest",
  }

  file{ "/etc/mrtg/":
    ensure => "directory",
    mode => "755",
    owner => "root",
    group => "root",
  }
  
  file{ "/etc/mrtg/conf.d":
    ensure => "directory",
    mode => "755",
    owner => "root",
    group => "root",
    require => File["/etc/mrtg/"],
  }
  
  file{ "/var/www/mrtg":
    ensure => "directory",
    mode => "755",
    owner => "root",
    group => "root",
    require => Package["apache2"],
  }

  # MRTG init script
  file { '/etc/init.d/mrtg':
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '755',
    source => 'puppet:///modules/sr-router/mrtg.init',
    before => Service['mrtg'],
  }

  # MRTG service
  service { 'mrtg':
    ensure      => running,
    enable      => true,
    hasrestart  => true,
    hasstatus   => false,
  }

  exec { "/usr/sbin/a2enmod rewrite":
    creates => "/etc/apache2/mods-enabled/rewrite.load"
  }

  exec { "/usr/sbin/a2ensite mrtg.net.studentrobotics.org":
    creates => "/etc/apache2/sites-enabled/mrtg.net.studentrobotics.org",
    require => File["/etc/apache2/sites-available/mrtg.net.studentrobotics.org"],
  }

  file { "/etc/apache2/sites-available/mrtg.net.studentrobotics.org":
    ensure => "present",
    source => "puppet:///modules/sr-router/mrtg.apache2.conf",
    mode => "644",
    owner => "root",
    group => "root",
    require => Exec["/usr/sbin/a2enmod rewrite"],
  }
  
  file{ "/usr/local/bin/create_mrtg_config":
    ensure => "present",
    mode => "744",
    owner => "root",
    group => "root",
    source => "puppet:///modules/sr-router/create_mrtg_config",
  }
  
  file{ "/etc/cron.d/mrtg":
    ensure => "present",
    mode => "644",
    owner => "root",
    group => "root",
    source => "puppet:///modules/sr-router/mrtg.cron",
  }

  exec{ "/usr/local/bin/create_mrtg_config":
    require => File["/usr/local/bin/create_mrtg_config"],
  }
  
    
}
