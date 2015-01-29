class agapered_pg(){
  user {"postgres" : 
    password => 'password' 
  }
  
  package { ['postgresql-9.3','libpq-dev'] :
    ensure => present
  }
  
  file { '/etc/postgresql/9.3/main/pg_hba.conf' :
    source => 'puppet:///modules/agapered_pg/pg_hba.conf',
    require => [ Package['postgresql-9.3'], [User["postgres"]] ],
    owner => 'postgres',
    group => 'postgres'	
  }
  
  file { '/etc/postgresql/9.3/main/alter_default_db.sql' :
    source => 'puppet:///modules/agapered_pg/alter_default_db.sql',
    require => [ Package['postgresql-9.3'], [User["postgres"]] ],
    owner => 'postgres',
    group => 'postgres'
  }
  
  exec { 'restart_postgres' :
    command => '/usr/bin/sudo /usr/sbin/service postgresql restart',
    require => [Package['postgresql-9.3'],File['/etc/postgresql/9.3/main/pg_hba.conf']]
  }
  
  exec { 'udpdate_default_db' :
    command => "/usr/bin/psql -U postgres < /etc/postgresql/9.3/main/alter_default_db.sql",
    require => [Package['postgresql-9.3'], File['/etc/postgresql/9.3/main/pg_hba.conf'], File['/etc/postgresql/9.3/main/alter_default_db.sql'], Exec['restart_postgres'] ]	
  }
}