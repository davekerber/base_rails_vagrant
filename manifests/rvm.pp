include rvm

if $rvm_installed == "true" {
	rvm_system_ruby { 'ruby-2.1.0':
	  ensure => 'present',
	  default_use => true;
	}
	rvm_gem {
      'ruby-2.1.0@global/puppet':
      ensure => 'present',
      require => Rvm_system_ruby['ruby-2.1.0'];

      'ruby-2.1.0@global/bundler':
      ensure => 'present',
      require => Rvm_system_ruby['ruby-2.1.0'];

      'ruby-2.1.0@global/pg':
      ensure => '0.14.1',
      require => [Rvm_system_ruby['ruby-2.1.0']];

	  'ruby-2.1.0@global/mailcatcher':
	  ensure => 'present',
	  require => Rvm_system_ruby['ruby-2.1.0'];
	}
}
