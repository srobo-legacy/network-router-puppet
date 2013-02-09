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

  # Chain to store authenticated users in
  firewallchain { 'is_authenticated:filter:IPv4':
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
  firewall { "FWD: 000 accept all icmp":
    chain  => "FORWARD",
    proto  => "icmp",
    action => "accept",
  }

  # Allow all traffic attached to established connections. Important for
  # connections made by the server.
  firewall { "000 FORWARD allow related and established":
    chain => "FORWARD",
    state => ["RELATED", "ESTABLISHED"],
    action => "accept",
    proto => "all",
  }

  # Allow traffic to Badger
  firewall { "001 Allow to Badger":
    chain => "FORWARD",
    proto => "tcp",
    destination => ['176.58.112.199/32'],
    jump => "LOG_ACCEPT",
  }

  # GoDaddy OCSP and CRLs
  firewall { "002 GoDaddy OCSP/CRLs":
    chain => "FORWARD",
    proto => "tcp",
    destination => ["72.167.18.237", "72.167.18.238", "72.167.18.239", "72.167.239.237", "72.167.239.238", "72.167.239.239", "188.121.36.237", "188.121.36.238", "188.121.36.239", "182.50.136.237", "182.50.136.238", "182.50.136.239", "50.63.243.228", "50.63.243.229", "50.63.243.230"],
    jump => "LOG_ACCEPT",
  }

  firewall { "003 Allow authenticated users":
    chain => "FORWARD",
    jump => "is_authenticated",
  }

  firewall { "004 Deny all other traffic":
    chain => "FORWARD",
    action => "reject",
  }

  firewall { "management_access - Default rule":
    chain => "management_access",
    outiface => "vlan102",
    proto => "tcp",
    jump => "LOG_ACCEPT,
  }

  firewall { "competitor_access - Default rule":
    chain => "competitor_access",
    outiface => "vlan103",
    proto => "tcp",
    jump => "LOG_ACCEPT,
  }

  firewall { "staff_access - Default rule":
    chain => "staff_access",
    outiface => "vlan104",
    proto => "tcp",
    jump => "LOG_ACCEPT,
  }

  firewall { "compnet_access - Default rule":
    chain => "compnet_access",
    outiface => "vlan105",
    proto => "tcp",
    jump => "LOG_ACCEPT,
  }

  firewall { "video_access - Default rule":
    chain => "competitor_access",
    outiface => "vlan106",
    proto => "tcp",
    jump => "LOG_ACCEPT,
  }

  firewall { "internet_access - ICMP ping request":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "icmp",
    icmp => 8
  }

  firewall { "internet_access - HTTP":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 80,
  }

  firewall { "internet_access - HTTPS":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 443,
  }

  firewall { "internet_access - HTTP Alt":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 8080,
  }

  firewall { "internet_access - HTTPS Alt":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 8443,
  }

  firewall { "internet_access - SSH":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 22,
  }

  firewall { "internet_access - SMTP/SSL":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 465,
  }

  firewall { "internet_access - Submission":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 587,
  }

  firewall { "internet_access - IMAP/SSL":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 993,
  }

  firewall { "internet_access - IMAP":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 220,
  }

  firewall { "internet_access - IMAP":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 143,
  }

  firewall { "internet_access - POP3/SSL":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 995,
  }

  firewall { "internet_access - POP3":
    chain => "internet_access",
    outiface => "vlan107",
    jump => "LOG_ACCEPT",
    proto => "tcp",
    dport => 110,
  }
}
