@tool
extends EditorPlugin

var script_editor: ScriptEditor
var file_system: EditorFileSystem

func _enter_tree() -> void:
	# Get references to the script editor and file system
	script_editor = get_editor_interface().get_script_editor()
	file_system = get_editor_interface().get_resource_filesystem()
	
	# Connect to the file_system's filesystem_changed signal
	file_system.connect("filesystem_changed", _on_filesystem_changed)

func _exit_tree() -> void:
	# Disconnect from signals when plugin is disabled
	if file_system and file_system.is_connected("filesystem_changed", _on_filesystem_changed):
		file_system.disconnect("filesystem_changed", _on_filesystem_changed)

func _on_filesystem_changed() -> void:
	# Wait a frame to let the file system update
	await get_tree().process_frame
	
	# Check all .gd files in the project
	var dir = DirAccess.open("res://")
	if dir:
		_scan_directory("res://", dir)

func _scan_directory(path: String, dir: DirAccess) -> void:
	# List files in the current directory
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if file_name != "." and file_name != "..":
			var full_path = path + file_name
			
			if dir.current_is_dir():
				var subdir = DirAccess.open(full_path)
				if subdir:
					_scan_directory(full_path + "/", subdir)
			elif file_name.ends_with(".gd"):
				_check_and_add_class_name(full_path)
			
		file_name = dir.get_next()
	
	dir.list_dir_end()

func _check_and_add_class_name(file_path: String) -> void:
	# Skip if the file is in the addons folder
	if file_path.begins_with("res://addons/"):
		return
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		return
	
	var content = file.get_as_text()
	file.close()
	
	# Skip if the file already has a class_name declaration
	if content.find("class_name ") != -1:
		return
	
	# Get the class name from the file name
	var file_name = file_path.get_file()
	var class_name_str = file_name.get_basename()
	
	# Convert to PascalCase (assuming file names are snake_case)
	var parts = class_name_str.split("_")
	class_name_str = ""
	for part in parts:
		if part.length() > 0:
			class_name_str += part[0].to_upper() + part.substr(1)
	
	# Check if the file was just created (by comparing modified time)
	var file_info = FileAccess.get_modified_time(file_path)
	var current_time = Time.get_unix_time_from_system()
	
	# If the file was modified in the last 5 seconds, consider it new
	if current_time - file_info < 5:
		# Add the class_name at the top of the file
		var new_content = "class_name " + class_name_str + "\n" + content
		
		var write_file = FileAccess.open(file_path, FileAccess.WRITE)
		if write_file:
			write_file.store_string(new_content)
			write_file.close()
			
			# Reload the script if it's currently open
			_reload_current_script(file_path)

func _reload_current_script(file_path: String) -> void:
	# Get all script editor tabs
	var editor_tabs = script_editor.get_open_scripts()
	
	for script_obj in editor_tabs:
		if script_obj.resource_path == file_path:
			# Force reload of the script
			script_editor.reload_scripts()
			break

# Plugin configuration
func _get_plugin_name() -> String:
	return "Auto Class Name"

func _get_plugin_icon() -> Texture2D:
	return get_editor_interface().get_base_control().get_theme_icon("Script", "EditorIcons")
