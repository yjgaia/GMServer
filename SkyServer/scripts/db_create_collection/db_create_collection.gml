/// @description db_create_collection(collection_name)
/// @param collection_name

var collection_name = argument0;

if (directory_exists(collection_name) != true) {
	directory_create(collection_name);
}