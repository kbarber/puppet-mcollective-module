class mcollective::client {
  include mcollective
  package {"mcollective-client":
    ensure => "1.1.0",
  }
  file {"/etc/mcollective/client.cfg":
    content => template("mcollective/client.cfg"),
    require => Package["mcollective"],
  }

  # Clients
  mcollective::script {"puppetd":
    type => "agent",
  }
  mcollective::script {"service":
    type => "agent",
  }
  mcollective::script {"filemgr":
    type => "agent",
  }
  mcollective::script {"nettest": 
    script => false,
    type => "agent",
  }
  mcollective::script {"package":
    type => "agent",
  }
  mcollective::script {"process":
    type => "agent",
  }
}
