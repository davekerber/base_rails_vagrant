include rvm

if $rvm_installed == "true" {
	rvm_system_ruby { 'ruby-2.1.4':
	  ensure => 'present',
	  default_use => true;
	}
	rvm_gem {
      'ruby-2.1.4@global/puppet':
      ensure => 'present',
      require => Rvm_system_ruby['ruby-2.1.4'];

      'ruby-2.1.4@global/bundler':
      ensure => 'present',
      require => Rvm_system_ruby['ruby-2.1.4'];

      'ruby-2.1.4@global/pg':
      ensure => '0.14.1',
      require => [Rvm_system_ruby['ruby-2.1.4']];

	  'ruby-2.1.4@global/mailcatcher':
	  ensure => 'present',
	  require => Rvm_system_ruby['ruby-2.1.4'];
	}
}
