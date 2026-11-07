class_name JSONDataLoader extends Node

## Loads json upgrade data

const PATH_JSON_DATA: String = "res://data/FTLCloneEventData.json"


## Loads and returns JSON data from the provided file path
func load_json_data_from_path(path: String):
	var file_string = FileAccess.get_file_as_string(path)
	var json_data
	if file_string != null:
		json_data = JSON.parse_string(file_string)
	else:
		push_warning("load_json_data_from_path failed get_file_as_string for path: ", path)
		
	if json_data == null:
		push_error("load_json_data_from_path failed parse file data to JSON for ", path)
		
	return json_data
