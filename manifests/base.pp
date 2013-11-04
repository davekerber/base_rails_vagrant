include rvm
include agapered_pg
include agapered_git
include agapered_nodocs

package { ['vim','zip','imagemagick'] :
  ensure => present
}

rvm::system_user { vagrant: ; }



