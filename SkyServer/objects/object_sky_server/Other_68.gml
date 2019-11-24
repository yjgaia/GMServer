/// @description 데이터 처리

var async_id = ds_map_find_value(async_load, "id");
var type = ds_map_find_value(async_load, "type");

// 누군가가 서버에 접속
if (async_id == raw_server && type == network_type_connect) {
	var socket = ds_map_find_value(async_load, "socket");
	if (ds_map_exists(received_strs, socket) != true) {
		ds_map_add(received_strs, socket, "");
	}
}
	
// 데이터를 받음
if (type == network_type_data) {
		
	var socket = ds_map_find_first(received_strs);
	for (var i = 0; i < ds_map_size(received_strs); i += 1) {
		
		if (socket == async_id) {
		    var received_str = ds_map_find_value(received_strs, socket);
			received_str += buffer_read(ds_map_find_value(async_load, "buffer"), buffer_string);
			show_debug_message(received_str);
			ds_map_replace(received_strs, socket, received_str);
			
	        var buffer = buffer_create(256, buffer_grow, 1);
	        buffer_seek(buffer, buffer_seek_start, 0);
	        buffer_write(buffer, buffer_string, "HTTP/1.0 200 OK\r\n" + 
				"Content-Length: 13\r\n" +
				"Content-Type: text/html\r\n" + 
				"\r\n" +
				"Hello SkyServer!\\n");
	        network_send_raw(socket, buffer, buffer_tell(buffer));
	        buffer_delete(buffer);
		}
	        
		socket = ds_map_find_next(received_strs, socket);
	}
}