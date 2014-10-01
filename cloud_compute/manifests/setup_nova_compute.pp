class cloud_compute::setup_nova_compute(
) inherits cloud_compute::params{

	class { 'nova::compute':
	  enabled => true,
	}

	class { 'nova::compute::libvirt':
	  
	}

}
