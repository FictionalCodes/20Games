@tool
extends EditorPlugin

const AUTOLOAD_NAME := "ResourceLoading"

func _enable_plugin():
	# The autoload can be a scene or script file.
	if not Engine.has_singleton(AUTOLOAD_NAME):
		add_autoload_singleton(AUTOLOAD_NAME, "res://addons/fictional_resource_loader/resource_loader/resource_loader_pluging.gd")

func _enter_tree() -> void:
	if not ProjectSettings.has_setting(ResourceLoaderQueueConsts.loader_queue_number_prop_path):
		ProjectSettings.set_setting(ResourceLoaderQueueConsts.loader_queue_number_prop_path, ResourceLoaderQueueConsts.loader_queue_max_load_number_default)
	ProjectSettings.add_property_info({
		"name": ResourceLoaderQueueConsts.loader_queue_number_prop_path,
		"type": TYPE_INT,
		"hint_string": ResourceLoaderQueueConsts.loader_queue_max_load_number_default,
	})
	ProjectSettings.set_initial_value(ResourceLoaderQueueConsts.loader_queue_number_prop_path, ResourceLoaderQueueConsts.loader_queue_max_load_number_default)
	ProjectSettings.set_as_basic(ResourceLoaderQueueConsts.loader_queue_number_prop_path, true)


func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)
	ProjectSettings.set_setting(ResourceLoaderQueueConsts.loader_queue_number_prop_path, null)
	
func _exit_tree() -> void:
	pass
