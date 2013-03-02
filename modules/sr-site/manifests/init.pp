# Root this-is-the-sr-server config file. Fans out to different kinds of service
# we operate.

# git_root: The root URL to access the SR git repositories
class sr-site( $git_root ) {

  # Default PATH
  Exec {
    path => [ "/usr/bin" ],
  }

  # Directory for 'installed flags' for various flavours of data. When some
  # piece of data is loaded from backup/wherever into a database, files here
  # act as a guard against data being reloaded.
  file { '/usr/local/var':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '755',
  }

  file { '/opt/sr':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '755',
  }

  file { '/usr/local/var/sr':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '700',
    require => File['/usr/local/var'],
  }

  include bee

  include sr-site::interfaces
  include sr-site::firewall
  include sr-site::freeradius
  include sr-site::mysql

  include sr-router

  class { "sr-www":
    git_root => $git_root,
    www_root => "/var/www",
  }

  class { "sr-libs":
    git_root => $git_root,
  }

  class { "sr-live": }

}

