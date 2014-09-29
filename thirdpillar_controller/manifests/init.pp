class thirdpillar_controller(
  $setup = true,
)inherits thirdpillar_controller::params{

#*************** setting up mysql **********************

class {'mysql::bindings':}

class { 'mysql::server':
    root_password => $root_password,
    old_root_password => $old_root_password,
}

class { 'mysql::server::account_security': }

Class['mysql::bindings'] -> Class['mysql::server'] -> Class['mysql::server::account_security']


#******************setting up Keystone********************
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

#*********************setting up glance******************

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

#******************************Setting Up Nova*************************
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


Class['mysql::server'] -> Class['nova::db::mysql'] 
Class['mysql::server'] -> Class['nova']
Class['mysql::server'] -> Class['nova::network']		

}
