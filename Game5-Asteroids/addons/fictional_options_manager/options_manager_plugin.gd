@tool
extends EditorPlugin

# Replace this value with a PascalCase autoload name, as per the GDScript style guide.
const AUTOLOAD_NAME := "FictionalOptionsManager"

func _enable_plugin():
	# The autoload can be a scene or script file.
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/fictional_options_manager/options_manager.gd")

	if not ProjectSettings.has_setting(OptionsManagerConsts.config_file_path_settings_prop_path):
		ProjectSettings.set_setting(OptionsManagerConsts.config_file_path_settings_prop_path, OptionsManagerConsts.config_file_path_default)
	ProjectSettings.add_property_info({
		"name": OptionsManagerConsts.config_file_path_settings_prop_path,
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"hint_string": OptionsManagerConsts.config_file_path_default,
	})
	ProjectSettings.set_initial_value(OptionsManagerConsts.config_file_path_settings_prop_path, OptionsManagerConsts.config_file_path_default)
	ProjectSettings.set_as_basic(OptionsManagerConsts.config_file_path_settings_prop_path, true)


func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)

func _enter_tree() -> void:
	pass

func _exit_tree() -> void:
	pass
