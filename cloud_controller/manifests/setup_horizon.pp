class cloud_controller::setup_horizon(
$memcached_listen_ip = "127.0.0.1",
$horizone_secrete_key = "tparunhappy1529horizon",
){
class { 'horizon': 
 secret_key => $horizone_secrete_key,
}

class { 'memcached': listen_ip => '127.0.0.1' }
}
