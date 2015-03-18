#class {
#	'install-wordpress':
#}

file {'/tmp/example-ip':                                            # resource type file and filename
  ensure  => present,                                               # make sure it exists
  mode    => 0644,                                                  # file permissions
  content => "Here is my Public IP Address: ${ipaddress_eth0}.\n",  # note the ipaddress_eth0 fact
}

node 'shared2' {
  file {'/tmp/dns':    # resource type file and filename
    ensure => present, # make sure it exists
    mode => 0644,
    content => "Only DNS servers get this file.\n",
  }
}

node default {}
