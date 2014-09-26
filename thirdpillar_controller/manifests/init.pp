class thirdpillar_controller(
  $setup = true,
)inherits thirdpillar_controller::params{

	class{'cloud_controller::setup_mysql':
		root_password => $root_password,
		bind_address => $bind_address,
	}

	->

	class {'cloud_controller::setup_keystone':
		admin_token => $admin_token,
		admin_email => $admin_email,
		keystone_admin_password => $keystone_admin_password,
		keystone_db_name => $keystone_db_name,
		keystone_db_user => $keystone_db_user,
		keystone_db_password => $keystone_db_password,
		mysql_allowed_hosts => $mysql_allowed_hosts,
		os_auth_url => $os_auth_url,
		service_end_point => $service_end_point,
	}

	->

	class {'cloud_controller::setup_glance':
		glance_db_name => $glance_db_name,
		glance_db_user => $glance_db_user,
		glance_db_password => $glance_db_password,
		mysql_allowed_hosts => $mysql_allowed_hosts,
		glance_keystone_password => $glance_keystone_password,
	}

	->	
  
	class {'cloud_controller::setup_nova':
		nova_db_name => $nova_db_name,
		nova_db_user => $nova_db_user,
		nova_db_password => $nova_db_password,
		mysql_allowed_hosts => $mysql_allowed_hosts,
		nova_keystone_password => $nova_keystone_password,
		keystone_admin_password => $keystone_admin_password,
		private_interface => $private_interface,
		public_interface => $public_interface,
		network_fixed_range => $network_fixed_range,
		num_networks => $num_networks,
		vlan_start => $vlan_start,
	}

	->

	class {'cloud_controller::setup_horizon':
		memcached_listen_ip => $memcached_listen_ip,
	}

#Class['cloud_controller::setup_mysql'] -> Class['cloud_controller::setup_keystone']
#Class['cloud_controller::setup_keystone'] -> Class['cloud_controller::setup_glance']
#Class['cloud_controller::setup_glance'] -> Class['cloud_controller::setup_nova']
#Class['cloud_controller::setup_nova'] -> Class['cloud_controller::setup_horizon']
}
