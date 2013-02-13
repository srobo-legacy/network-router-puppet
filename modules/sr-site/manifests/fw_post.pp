class sr-site::fw_post {

  firewall { '999 drop all':
    action  => 'drop',
  }  

  firewall { '999 drop all':
    chain => 'FORWARD',
    action  => 'drop',
  }  
}
