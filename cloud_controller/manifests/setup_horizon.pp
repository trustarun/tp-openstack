class cloud_controller::setup_horizon(
) inherits cloud_controller::params {

	class { 'horizon':
	 secret_key => $horizone_secrete_key,
         keystone_url => $os_auth_url,
	}

	class { 'memcached': listen_ip => '127.0.0.1' }

}
