class profiles::mesos::master {
  class { ::docker:}
  ->
  class{ ::mesos::master:
    zookeeper  => "zk://${ipaddress_eth0}:2181/mesos",
    work_dir => '/var/lib/mesos',
    listen_address => $::ipaddress_eth0,
    options => {
      'quorum'  => '1',
      'hostname' => $ipaddress_eth0,
    }
  }
  ->
  class { ::mesosphere::marathon:}

  @@host { $::hostname:
    ip            => $::ipaddress_eth0,
    host_aliases  => 'mesosmaster',
  }

  Host <<| |>>
}
