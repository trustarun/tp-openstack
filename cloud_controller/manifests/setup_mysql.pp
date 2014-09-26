class cloud_controller::setup_mysql(
$root_password = "tparun1529",
$bind_address = "0.0.0.0",
){

class {'mysql::bindings':}

->

class { 'mysql::server':
    root_password => $root_password,
}
->
# Secure the MySQL installation
class { 'mysql::server::account_security': }
}
