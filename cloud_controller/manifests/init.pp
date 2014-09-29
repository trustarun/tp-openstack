class cloud_controller{

	class {'cloud_controller::setup_mysql':
		before => Class['cloud_controller::setup_keystone'],
	}

	class {'cloud_controller::setup_keystone':
		before => Class['cloud_controller::setup_glance'],
	}

	class {'cloud_controller::setup_glance':
		before => Class['cloud_controller::setup_nova'],
	}

	class {'cloud_controller::setup_nova':
        	before => Class['cloud_controller::setup_horizon']
	}

        class {'cloud_controller::setup_horizon':}

}
