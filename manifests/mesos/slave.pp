class profiles::mesos::slave {

  include docker

  class{ ::mesos::slave:
    zookeeper       => "zk://mesosmaster:2181/mesos",
    listen_address  => $::ipaddress_eth0,
#    isolation       => 'cgroups/cpu,cgroups/mem',
    options         => {
      'containerizers'  => 'docker,mesos',
      'log_dir'         => '/var/log/mesos',
    },
  }

  @@host { $::hostname:
    ip => $::ipaddress_eth0,
  }

  Host <<| |>>
}
