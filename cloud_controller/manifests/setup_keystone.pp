class cloud_controller::setup_keystone(
$admin_token = "tparunxyz1529happy",
$admin_email = "trustarun@yahoo.co.in",
$keystone_admin_password = "tparun1529",
$keystone_db_name = "keystone",
$keystone_db_user = "keystone",
$keystone_db_password = "tparun1529",
$mysql_allowed_hosts = ['127.0.0.%', '10.0.0.%'],
$os_auth_url = "http://localhost:5000/v2.0/",
$service_end_point = "http://localhost:35357/v2.0/",
) inherits cloud_controller::params {

# Create a MySQL db for Keystone
class { 'keystone::db::mysql':
  user          => $keystone_db_user,
  password      => $keystone_db_password,
  dbname        => $keystone_db_user,
  allowed_hosts => $mysql_allowed_hosts,
  mysql_module => $mysql_module,
}

# Install Keystone
class { 'keystone':
  catalog_type => 'sql',
  admin_token  => $admin_token,
  mysql_module => $mysql_module,
} 

# Keystone admin role
class { 'keystone::roles::admin':  
  email        => $admin_email,
  password     => $keystone_admin_password,
  admin_tenant => 'admin',
}

# Add a Keystone service
class { 'keystone::endpoint': }

# Create an openrc file.creating an openrc file will provide allow the ability to 
#perform Keystone and other OpenStack commands without specifying credentials
file { '/root/openrc':
  ensure    => present,
  owner     => 'root',
  group     => 'root',
  mode      => '0600',
  content   =>
"export OS_TENANT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=${keystone_admin_password}
export OS_AUTH_URL=${os_auth_url}
export OS_AUTH_STRATEGY=keystone
export SERVICE_TOKEN=${admin_token}
export SERVICE_ENDPOINT=${service_end_point}
"
}

}
