class cloud_compute::setup_nova_volume(
) inherits cloud_compute::params{

	# Install and configure nova-volume
	class { 'nova::volume': enabled => true }

	# Use ISCSI / LVM volumes
	class { 'nova::volume::iscsi': }

}
