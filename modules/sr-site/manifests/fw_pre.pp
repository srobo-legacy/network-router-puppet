class sr-site::fw_pre {

  # Create some firewall chains for forwarding

  # Access to the management network
  firewallchain { 'management_access:filter:IPv4':
    ensure  => present,
  }

  # Access to the competitor network
  firewallchain { 'competitor_access:filter:IPv4':
    ensure  => present,
  }

  # Access to the staff network
  firewallchain { 'staff_access:filter:IPv4':
    ensure  => present,
  }

  # Access to the competition service network
  firewallchain { 'compnet_access:filter:IPv4':
    ensure  => present,
  }

  # Access to the video hosts
  firewallchain { 'video_access:filter:IPv4':
    ensure  => present,
  }

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
  firewall { "002 ssh from management":
    iniface => "vlan102",
    proto  => "tcp",
    dport => 22,
    action => "accept",
  }

  # Allow staff to connect to SSH
  firewall { "003 ssh from staff":
    iniface => "vlan104",
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

  # Allow NTP from management
  firewall { "006 NTP":
    iniface => "vlan102",
    proto => "udp",
    dport => 123,
    action => "accept",
  }

  # Allow NTP from management
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
  firewall { "011 NFS UDP 111 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "udp",
    dport => 111,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "012 NFS UDP 111 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "udp",
    dport => 111,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "013 NFS UDP 111 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "udp",
    dport => 111,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "014 NFS UDP 2049 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "udp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "015 NFS UDP 2049 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "udp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "016 NFS UDP 2049 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "udp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "017 NFS UDP 4000 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "udp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "018 NFS UDP 4000 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "udp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "019 NFS UDP 4000 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "udp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "020 NFS UDP 4001 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "udp",
    dport => 4001,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "021 NFS UDP 4001 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "udp",
    dport => 4001,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "022 NFS UDP 4001 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "udp",
    dport => 4001,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "023 NFS UDP 4002 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "udp",
    dport => 4002,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "024 NFS UDP 4002 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "udp",
    dport => 4002,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "025 NFS UDP 4002 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "udp",
    dport => 4002,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "011 NFS TCP 111 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "tcp",
    dport => 111,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "012 NFS TCP 111 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "tcp",
    dport => 111,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "013 NFS TCP 111 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "tcp",
    dport => 111,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "014 NFS TCP 2049 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "tcp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "015 NFS TCP 2049 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "tcp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "016 NFS TCP 2049 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "tcp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "017 NFS TCP 4000 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "tcp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "018 NFS TCP 4000 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "tcp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "019 NFS TCP 4000 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "tcp",
    dport => 2049,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "020 NFS TCP 4001 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "tcp",
    dport => 4001,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "021 NFS TCP 4001 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "tcp",
    dport => 4001,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "022 NFS TCP 4001 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
    proto => "tcp",
    dport => 4001,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "023 NFS TCP 4002 (Arena PXE)":
    source => [ '172.18.5.0/24' ],
    proto => "tcp",
    dport => 4002,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "024 NFS TCP 4002 (Competitor PXE)":
    source => [ '172.18.7.0/24' ],
    proto => "tcp",
    dport => 4002,
    action => "accept",
  }

  # NFS for PXE Clients
  firewall { "025 NFS TCP 4002 (Staff PXE)":
    source => [ '172.18.8.0/24' ],
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
    iniface => "vlan104",
    chain => "FORWARD",
    proto => "tcp",
    jump => "internet_access",
  }

  # Allow traffic from staff to the competition network
  firewall { "101 Allow staff to have compnet access":
    iniface => "vlan104",
    chain => "FORWARD",
    proto => "tcp",
    jump => "compnet_access",
  }

  # Allow traffic from staff to the internet
  firewall { "102 Allow staff to have video access":
    iniface => "vlan104",
    chain => "FORWARD",
    proto => "tcp",
    jump => "video_access",
  }
  
  firewall { "200 Allow authenticated users":
    chain => "FORWARD",
    jump => "is_authenticated",
  }

  firewall { "999 Deny all other traffic":
    chain => "FORWARD",
    action => "reject",
  }

  firewall { "000 management_access - Default rule":
    chain => "management_access",
    proto => "tcp",
    jump => "LOG_ACCEPT",
  }

  firewall { "000 competitor_access - Default rule":
    chain => "competitor_access",
    proto => "tcp",
    jump => "LOG_ACCEPT",
  }

  firewall { "000 staff_access - Default rule":
    chain => "staff_access",
    proto => "tcp",
    jump => "LOG_ACCEPT",
  }

  firewall { "000 compnet_access - Default rule":
    chain => "compnet_access",
    proto => "tcp",
    jump => "LOG_ACCEPT",
  }

  firewall { "000 video_access - Default rule":
    chain => "video_access",
    proto => "tcp",
    jump => "LOG_ACCEPT",
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
  firewall { "003 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.237", 
    action => "accept",
  }
  firewall { "004 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.238", 
    action => "accept",
  }
  firewall { "005 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.18.239", 
    action => "accept",
  }
  firewall { "006 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.237", 
    action => "accept",
  }
  firewall { "007 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.238", 
    action => "accept",
  }
  firewall { "008 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "72.167.239.239", 
    action => "accept",
  }
  firewall { "009 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.237", 
    action => "accept",
  }
  firewall { "010 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.238", 
    action => "accept",
  }
  firewall { "011 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "188.121.36.239", 
    action => "accept",
  }
  firewall { "012 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.237", 
    action => "accept",
  }
  firewall { "013 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.238", 
    action => "accept",
  }
  firewall { "014 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "182.50.136.239", 
    action => "accept",
  }
  firewall { "015 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.228", 
    action => "accept",
  }
  firewall { "016 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.229", 
    action => "accept",
  }
  firewall { "017 nat - GoDaddy OCSP/CRLs":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    destination => "50.63.243.230",
    action => "accept",
  }
  firewall { "018 DNAT all HTTP to captive":
    table => "nat",
    chain => "PREROUTING",
    proto => "tcp",
    dport => 80,
    jump => "DNAT",
    todest => "172.18.2.1:80",
  }
  firewall { "001 Masquerade all traffic":
    table => "nat",
    chain => "POSTROUTING",
    jump => "MASQUERADE",
  }
}
