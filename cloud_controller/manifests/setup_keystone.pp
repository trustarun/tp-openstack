class cloud_controller::setup_keystone(
) inherits cloud_controller::params {

	class { 'keystone::db::mysql':
	  user          => $keystone_db_user,
	  password      => $keystone_db_password,
	  dbname        => $keystone_db_user,
	  allowed_hosts => $mysql_allowed_hosts,
	  mysql_module => $mysql_module,
	}

	class { 'keystone':
	  catalog_type => 'sql',
	  admin_token  => $admin_token,
	  mysql_module => $mysql_module,
	} 

	# Keystone admin role
	class { 'keystone::roles::admin':  
	  email        => $admin_email,
	  password     => $keystone_admin_password,
	}

	# Add a Keystone service
	class { 'keystone::endpoint': }

	Class['mysql::server'] -> Class['keystone::db::mysql']
	Class['keystone::db::mysql'] -> Class['keystone']

}
