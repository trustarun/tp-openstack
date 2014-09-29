class thirdpillar_controller::params{
#Mysql Variables
$mysql_allowed_hosts = ['127.0.0.%', '10.0.0.%']
$root_password = "tparun1529"
$mysql_module = 3 # must be higher then version 2.2




#keystone variables
$admin_token = "tparunxyz1529happy"
$admin_email = "trustarun@yahoo.co.in"
$keystone_admin_password = "tparun1529"
$keystone_db_name = "keystone"
$keystone_db_user = "keystone"
$keystone_db_password = "tparun1529"
$os_auth_url = "http://localhost:5000/v2.0/"
$service_end_point = "http://localhost:35357/v2.0/"


#glance variables
$glance_db_name = "glance"
$glance_db_user = "glance"
$glance_db_password = "tparun1529"
$glance_keystone_password = "tparun1529"


#nova variables
$nova_db_name = "nova"
$nova_db_user = "nova"
$nova_db_password = "tparun1529"
$nova_keystone_password = "tparun1529"
$private_interface = "eth1"
$public_interface = "eth0"
$network_fixed_range = "192.168.177.167/24"
$num_networks = "1"
$vlan_start = "100"

#horizon variables
$horizone_secrete_key = "tparunhappy1529horizon"
$memcached_listen_ip = "127.0.0.1"
}
