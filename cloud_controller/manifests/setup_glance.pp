class cloud_controller::setup_glance(
)inherits cloud_controller::params{

	# Configure a MySQL DB for Glance
	class { 'glance::db::mysql':
	  user          => $glance_db_user,
	  password      => $glance_db_password,
	  dbname        => $glance_db_name,
	  allowed_hosts => $mysql_allowed_hosts,
	  mysql_module => $mysql_module,
	}



	# Install glance-api and configure it to use Keystone
	class { 'glance::api':
	  auth_type         => 'keystone',
	  keystone_tenant   => 'services',
	  keystone_user     => 'glance',
	  keystone_password => $glance_keystone_password,
	  mysql_module => $mysql_module,
	}



	# Install glance-registry and configure it to use Keystone
	class { 'glance::registry':
	  auth_type         => 'keystone',
	  keystone_tenant   => 'services',
	  keystone_user     => 'glance',
	  keystone_password => $glance_keystone_password,
	  database_connection => "mysql://glance:${glance_db_password}@localhost/glance",
	  mysql_module => $mysql_module,
	}



	# Have Glance use a file storage back-end
	class { 'glance::backend::file': }



	# Configure Keystone for Glance
	class { 'glance::keystone::auth':  
	  password => $glance_keystone_password,
	}

	Class['mysql::server'] -> Class['glance::registry']

}
