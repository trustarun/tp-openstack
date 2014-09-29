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

	# Create an openrc file.It will allow to perform keystone task without entering credential every time
	file { '/root/openrc':
	  ensure    => present,
	  owner     => 'root',
	  group     => 'root',
	  mode      => '0600',
	  content   =>
	"
	export OS_TENANT_NAME=openstack
	export OS_USERNAME=admin
	export OS_PASSWORD=${keystone_admin_password}
	export OS_AUTH_URL=${os_auth_url}
	export OS_AUTH_STRATEGY=keystone
	export SERVICE_TOKEN=${admin_token}
	export SERVICE_ENDPOINT=${service_end_point}
	"
	}

        #order the keystone resource
	Class['mysql::server'] -> Class['keystone::db::mysql']
	Class['keystone::db::mysql'] -> Class['keystone']

}
