class agapered_nodocs(){
  file { '/etc/gemrc':
    source => "puppet:///modules/agapered_nodocs/gemrc"
  }
}