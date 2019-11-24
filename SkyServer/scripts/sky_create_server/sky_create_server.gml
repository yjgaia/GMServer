/// @description sky_create_server(port)
/// @param port

// params
var port = argument0;

with (instance_create_depth(0, 0, 0, object_sky_server)) {
	raw_server = network_create_server_raw(network_socket_tcp, port, 1014);
	if (raw_server < 0) {
		show_message("서버 생성 오류");
	}
}