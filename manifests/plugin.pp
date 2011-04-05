define mcollective::plugin(
  $type = "agent"
  ) {

  file {"/usr/libexec/mcollective/mcollective/${type}/${name}.rb":
    source => "puppet:///mcollective/plugins/${type}/${name}/${name}.rb",
    require => Package["mcollective"],
    notify => Service["mcollective"],
  }
}
