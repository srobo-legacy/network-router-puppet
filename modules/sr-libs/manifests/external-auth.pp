# Primary configuartion for the "External Authentication" system

class sr-libs::external-auth ( $git_root, $ext_auth_root_dir ) {

  # Directory permissions and ownership of the external-auth directory. Seeing how
  # /var/www/html belongs to root by default on fedora.
  file { "${ext_auth_root_dir}":
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '644',
    before => Vcsrepo[ "${ext_auth_root_dir}" ],
  }

  # Maintain a checkout of the external auth system
  vcsrepo { "${ext_auth_root_dir}":
    ensure => present,
    user => 'root',
    provider => git,
    source => "${git_root}/external-auth.git",
    revision => "origin/master",
    force => true,
    require => Package[ "php5" ],
  }

  file { "/usr/share/php":
    ensure => 'directory',
    owner => 'root',
    group => 'root',
    mode => 755,
  }

  # Symlink to make it appear in the right place
  file { "/usr/share/php/SSOClient.php":
    ensure => 'link',
    target => "${ext_auth_root_dir}/client/SSOClient.php",
    require => [ File[ "/usr/share/php" ], Package[ "php5" ], Vcsrepo[ "${ext_auth_root_dir}" ] ],
  }

}
