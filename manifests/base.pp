include agapered_git
include agapered_nodocs

package { ['vim','zip','imagemagick','mysql-server-5.5', 'mysql-client-5.5', 'libmysqlclient-dev', 'libmagickcore-dev', 'libmagickwand-dev'] :
  ensure => present
}

