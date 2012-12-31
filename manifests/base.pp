include rvm
include agapered_pg
include agapered_git

package { ['vim','zip','imagemagick'] :
  ensure => present
}

rvm::system_user { vagrant: ; }

rvm_system_ruby { 'ruby-1.9.3-p286':
  ensure => 'present',
  default_use => true;
}

rvm_gem {
  'ruby-1.9.3-p286@global/puppet':
  ensure => 'present',
  require => Rvm_system_ruby['ruby-1.9.3-p286'];

  'ruby-1.9.3-p286@global/bundler':
  ensure => 'present',
  require => Rvm_system_ruby['ruby-1.9.3-p286'];

  'ruby-1.9.3-p286@global/pg':
  ensure => '0.14.1',
  require => [Rvm_system_ruby['ruby-1.9.3-p286'],Package[libpq-dev]];

  'ruby-1.9.3-p286@global/mailcatcher':
  ensure => 'present',
  require => Rvm_system_ruby['ruby-1.9.3-p286'];
}

