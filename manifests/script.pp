define mcollective::script(
  $type = "agent",
  $script = true
  ) {

  if($script) {
    file {"/usr/sbin/mc-${name}":
      mode => 755,
      source => "puppet:///mcollective/plugins/${type}/${name}/mc-${name}",
    }
  }

  file {"/usr/libexec/mcollective/mcollective/${type}/${name}.ddl":
    source => "puppet:///mcollective/plugins/${type}/${name}/${name}.ddl",
    require => Package["mcollective"],
  }
}

