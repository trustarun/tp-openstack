class cloud_compute::network_config(
) inherits cloud_compute::params{

	nova_config { 'vlan_interface': 
		value => $private_interface 
	}

}
