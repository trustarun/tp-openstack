class cloud_compute::mysql_connect(
) inherits cloud_compute::params{

	# Install MySQL client libraries
	class { 'mysql': }
	class { 'mysql::python': }

	# Nova base configuration
	class { 'nova':
	  sql_connection => "mysql://nova:${nova_db_password}@${cloud_controller_ip}/nova",
	  rabbit_host    => $cloud_controller_ip,
	}
}
