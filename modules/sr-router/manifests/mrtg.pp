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
  
  file{ "/var/www/":
    ensure => "directory",
    mode => "755",
    owner => "root",
    group => "root",
    require => Package["apache2"],
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
