# git_root: The root URL to access the SR git repositories
class sr-libs( $git_root ) {

  # Default PATH
  Exec {
    path => [ "/usr/bin" ],
  }

  class { "sr-libs::external-auth":
    git_root => $git_root,
    ext_auth_root_dir => "/usr/share/sr-external-auth",
  }

}

