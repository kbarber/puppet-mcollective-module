class mcollective::server {
  include mcollective
  package {"mcollective":
    ensure => "1.1.0",
    notify => Service["mcollective"],
  }
  file {"/etc/mcollective/server.cfg":
    content => template("mcollective/server.cfg"),
    require => Package["mcollective"],
    notify => Service["mcollective"],
  }
  file{"/etc/mcollective/facts.yaml":
    owner   => root,
    group   => root,
    mode    => 400,

    # avoid including highly-dynamic facts as they will cause unnecessary 
    # template writes
    content => inline_template("<%= scope.to_hash.reject { |k,v| k =~ /(memoryfree|swapfree|uptime)/ || !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),

    loglevel => debug,
    require => Package["mcollective"],
  }
  service {"mcollective":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package["mcollective"],
  }

  # Agents
  mcollective::plugin {"puppetd":
    type => "agent",
  }
  mcollective::plugin {"service":
    type => "agent",
  }
  mcollective::plugin {"filemgr":
    type => "agent",
  }
  mcollective::plugin {"nettest":
    type => "agent",
  }
  mcollective::plugin {"package":
    type => "agent",
  }
  mcollective::plugin {"process":
    type => "agent",
  }
  mcollective::plugin {"puppetral":
    type => "agent", 
  }
}
