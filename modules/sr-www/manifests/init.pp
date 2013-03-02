class sr-www($git_root, $www_root){

  include sr-www::apache2
  include sr-www::php

  class { "sr-www::captive-portal":
    git_root => $git_root,
  }

}
