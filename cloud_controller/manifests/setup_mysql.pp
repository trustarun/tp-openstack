class cloud_controller::setup_mysql(
) inherits cloud_controller::params {

	class {'mysql::bindings':}

	class { 'mysql::server':
		root_password => $root_password,
		old_root_password => $old_root_password,
	}

	class { 'mysql::server::account_security': }

	Class['mysql::bindings'] -> Class['mysql::server'] -> Class['mysql::server::account_security']

}
