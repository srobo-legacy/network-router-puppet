class sr-site::fw_pre {

  # Create some firewall chains for forwarding

  # Chain that allows internet access
  firewallchain { 'internet_access:filter:IPv4':
    ensure  => present,
  }

  # 2 chains to store authenticated users in
  firewallchain { 'is_authenticated:filter:IPv4':
    ensure  => present,
  }

  firewallchain { 'is_authenticated:nat:IPv4':
    ensure  => present,
  }

  # LOG and ACCEPT a packet
  firewallchain { 'LOG_ACCEPT:filter:IPv4':
    ensure  => present,
  }

  # Allow ICMP on the INPUT chain
  firewall { "000 accept all icmp":
    proto  => "icmp",
    action => "accept",
  }

  # Allow all loopback traffic
  firewall { "001 allow loopback":
    iniface => "lo",
    chain => "INPUT",
    action => "accept",
  }

  # Allow all traffic attached to established connections. Important for
  # connections made by the server.
  firewall { "000 INPUT allow related and established":
    state => ["RELATED", "ESTABLISHED"],
    action => "accept",
    proto => "all",
  }

  if($devmode){
    firewall { "001 ssh for vagrant":
      iniface => "eth0",
      proto => "tcp",
      dport => 22,
      action => "accept",
    }
  }

  # Allow management network to connect to ssh.
  firewall { "002 ssh from staff network":
    iniface => "eth1",
    proto  => "tcp",
    dport => 22,
    action => "accept",
  }

  # Allow DNS (TCP)
  firewall { "004 DNS (TCP)":
    proto => "tcp",
    dport => 53,
    action => "accept",
  }

  # Allow DNS (UDP)
  firewall { "005 DNS (UDP)":
    proto => "udp",
    dport => 53,
    action => "accept",
  }

  # Allow NTP
  firewall { "006 NTP":
    proto => "udp",
    dport => 123,
    action => "accept",
  }

  # Allow DHCP
  firewall { "007 DHCP clients":
    proto => "udp",
    sport => 68,
    dport => 67,
    action => "accept",
  }

  # Allow everyone to connect to the HTTP website
  firewall { "008 HTTP":
    proto => "tcp",
    dport => 80,
    action => "accept",
  }

  # Allow everyone to connect to the SSL website
  firewall { "009 HTTPS":
    proto => "tcp",
    dport => 443,
    action => "accept",
  }

  # Allow everyone to do TFTP downloads
  firewall { "010 TFTP":
    proto => "udp",
    dport => 69,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "011 NFS UDP 111":
    proto => "udp",
    dport => 111,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "014 NFS UDP 2049":
    proto => "udp",
    dport => 2049,
    action => "accept",
  }
  
  # NFS for PXE Clients
  firewall { "017 NFS UDP 4000":
    proto => "udp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "020 NFS UDP 4001":
    proto => "udp",
    dport => 4001,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "023 NFS UDP 4002":
    proto => "udp",
    dport => 4002,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "011 NFS TCP 111":
    proto => "tcp",
    dport => 111,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "014 NFS TCP 2049":
    proto => "tcp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "017 NFS TCP 4000":
    proto => "tcp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "020 NFS TCP 4001":
    proto => "tcp",
    dport => 4001,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "023 NFS TCP 4002":
    proto => "tcp",
    dport => 4002,
    action => "accept",
  }

  ###### FORWARD CHAIN ######

  # Allow ICMP on the FORWARD chain
  firewall { "000 forward all icmp":
    chain  => "FORWARD",
    proto  => "icmp",
    action => "accept",
  }

  # Allow all traffic attached to established connections. Important for
  # connections made by the server.
  firewall { "001 FORWARD allow related and established":
    chain => "FORWARD",
    state => ["RELATED", "ESTABLISHED"],
    action => "accept",
    proto => "all",
  }

  # Allow traffic to Badger
  firewall { "002 Allow to Badger":
    chain => "FORWARD",
    proto => "tcp",
    destination => ['176.58.112.199/32'],
    jump => "LOG_ACCEPT",
  }

  # GoDaddy OCSP and CRLs
  firewall { "050 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.237", 
    jump => "LOG_ACCEPT",
  }
  firewall { "051 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.238", 
    jump => "LOG_ACCEPT",
  }
  firewall { "052 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.239", 
    jump => "LOG_ACCEPT",
  }
  firewall { "053 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.237", 
    jump => "LOG_ACCEPT",
  }
  firewall { "054 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.238", 
    jump => "LOG_ACCEPT",
  }
  firewall { "055 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.239", 
    jump => "LOG_ACCEPT",
  }
  firewall { "056 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.237", 
    jump => "LOG_ACCEPT",
  }
  firewall { "057 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.238", 
    jump => "LOG_ACCEPT",
  }
  firewall { "058 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.239", 
    jump => "LOG_ACCEPT",
  }
  firewall { "059 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.237", 
    jump => "LOG_ACCEPT",
  }
  firewall { "060 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.238", 
    jump => "LOG_ACCEPT",
  }
  firewall { "061 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.239", 
    jump => "LOG_ACCEPT",
  }
  firewall { "062 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.228", 
    jump => "LOG_ACCEPT",
  }
  firewall { "063 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.229", 
    jump => "LOG_ACCEPT",
  }
  firewall { "064 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.230",
    jump => "LOG_ACCEPT",
  }
  
  # Allow traffic from staff to the internet
  firewall { "100 Allow staff to have internet access":
    iniface => "eth1",
    chain => "FORWARD",
    proto => "tcp",
    jump => "internet_access",
  }

  firewall { "200 Allow authenticated users":
    chain => "FORWARD",
    jump => "is_authenticated",
  }

  firewall { "999 Deny all other traffic":
    chain => "FORWARD",
    action => "reject",
  }

  firewall { "000 internet_access - ICMP ping request":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "icmp",
    icmp => 8
  }

  firewall { "001 - internet_access - HTTP":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 80,
  }

  firewall { "002 - internet_access - HTTPS":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 443,
  }

  firewall { "003 internet_access - HTTP Alt":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 8080,
  }

  firewall { "004 internet_access - HTTPS Alt":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 8443,
  }

  firewall { "005 internet_access - SSH":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 22,
  }

  firewall { "006 - internet_access - SMTP/SSL":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 465,
  }

  firewall { "007 - internet_access - Submission":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 587,
  }

  firewall { "008 internet_access - IMAP/SSL":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 993,
  }

  firewall { "009 internet_access - IMAP3":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 220,
  }

  firewall { "010 internet_access - IMAP4":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 143,
  }

  firewall { "011 internet_access - POP3/SSL":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 995,
  }

  firewall { "012 internet_access - POP3":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 110,
  }

  firewall { "013 internet_access - IRC":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 6667,
  }

  firewall { "014 internet_access - NTP":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 123,
  }

  firewall { "015 internet_access - NTP":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "udp",
    dport => 123,
  }

  firewall { "016 internet_access - GIT":
    chain => "internet_access",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 9418,
  }

  firewall { "000 LOG_ACCEPT - Add logging":
    chain => "LOG_ACCEPT",
    proto => "tcp",
    jump => "LOG",
  }

  firewall { "001 LOG_ACCEPT - Accept packet":
    chain => "LOG_ACCEPT",
    proto => "tcp",
    action => "accept",
  }

  firewall { "001 Allow authenticated users":
    chain => "PREROUTING",
    jump => "is_authenticated",
    table => "nat",
  }

  firewall { "002 nat - Allow to Badger":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    destination => ['176.58.112.199/32'],
    action => "accept",
  }

  # GoDaddy OCSP and CRLs
  firewall { "050 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.237", 
    action => "accept",
  }
  firewall { "051 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.238", 
    action => "accept",
  }
  firewall { "052 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.239", 
    action => "accept",
  }
  firewall { "053 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.237", 
    action => "accept",
  }
  firewall { "054 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.238", 
    action => "accept",
  }
  firewall { "055 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.239", 
    action => "accept",
  }
  firewall { "056 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.237", 
    action => "accept",
  }
  firewall { "057 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.238", 
    action => "accept",
  }
  firewall { "058 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.239", 
    action => "accept",
  }
  firewall { "059 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.237", 
    action => "accept",
  }
  firewall { "060 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.238", 
    action => "accept",
  }
  firewall { "061 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.239", 
    action => "accept",
  }
  firewall { "062 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.228", 
    action => "accept",
  }
  firewall { "063 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.229", 
    action => "accept",
  }
  firewall { "064 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.230",
    action => "accept",
  }
  
  # Allow traffic from staff to the internet
  firewall { "100 Prevent staff from being captive portaled":
    iniface => "eth1",
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    action => "accept",
  }
  
  firewall { "200 DNAT all HTTP to captive":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    jump => "DNAT",
    todest => "172.18.0.1:80",
  }
  firewall { "210 DNAT all DNS to local (UDP)":
    table => "nat",
    chain => "PREROUTING",
    proto => "udp",
    dport => 53,
    jump => "DNAT",
    todest => "172.18.0.1:53",
  }
  firewall { "211 DNAT all DNS to local (TCP)":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 53,
    jump => "DNAT",
    todest => "172.18.0.1:53",
  }
  firewall { "001 Masquerade all traffic":
    table => "nat",
    chain => "POSTROUTING",
    jump => "MASQUERADE",
  }
}
