class cloud_compute{

	class {'cloud_compute::mysql_connect':
		before => Class['cloud_compute::setup_nova_compute']
	}

	class {'cloud_compute::setup_nova_compute':
		before => Class['cloud_compute::setup_nova_volume']
	}

	class {'cloud_compute::setup_nova_volume':
		before => Class['cloud_compute::network_config']
	}

	class {'cloud_compute::network_config':}

}
