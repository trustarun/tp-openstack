class cloud_controller::setup_nova(
)inherits cloud_controller::params{

	# Configure a MySQL database for Nova
	class { 'nova::db::mysql':
	  user          => $nova_db_user,
	  password      => $nova_db_password,
	  dbname        => $nova_db_name,
	  allowed_hosts => $mysql_allowed_hosts,
	  mysql_module => $mysql_module,
	}

	# Install and configure Nova
	class { 'nova':
	 database_connection => "mysql://nova:${nova_db_password}@localhost/nova",
	 mysql_module => $mysql_module,
	}


	# Install and configure nova-api
	class { 'nova::api':
	  enabled        => true,
	  admin_password => $keystone_admin_password,
	}


	# Configure various nova subcomponents
	class { 'nova::scheduler': enabled => true }

	class { 'nova::objectstore': enabled => true }

	class { 'nova::cert': enabled => true }

	class { 'nova::vncproxy': enabled => true }

	class { 'nova::consoleauth': enabled => true }

	# Configure nova-network
	class { 'nova::network': 
	  enabled            => true,
	  network_manager    => 'nova.network.manager.VlanManager',
	  private_interface  => $private_interface,
	  public_interface   => $public_interface,
	  fixed_range        => $network_fixed_range,
	  num_networks       => $num_networks,
	  config_overrides => {
	   vlan_start => $vlan_start,
	 }
	}

	# Configure Keystone for Nova
	class { 'nova::keystone::auth':
	  password => $nova_keystone_password,
	}

	#order the nova resource
	Class['mysql::server'] -> Class['nova::db::mysql'] 
	Class['mysql::server'] -> Class['nova']
	Class['mysql::server'] -> Class['nova::network']

}
