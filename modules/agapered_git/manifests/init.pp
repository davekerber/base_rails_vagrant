class agapered_git(){
  package { ['git'] :
    ensure => present
  }

  file {'/home/vagrant/.ssh/id_rsa':
    source => '/host_folder/id_rsa',
    owner => 'vagrant',
    group => 'vagrant'
  }

  file {'/home/vagrant/.ssh/id_rsa.pub':
    source => '/host_folder/id_rsa.pub',
    owner => 'vagrant',
    group => 'vagrant'
  }

  exec { 'configure git' :
    command => "/usr/bin/git config -f /home/vagrant/.gitconfig color.ui true ; /usr/bin/git config -f /home/vagrant/.gitconfig user.name '$git_name' ;",
    user => 'vagrant',
    cwd => '/home/vagrant',
	require => [Package['git']]
  }
}