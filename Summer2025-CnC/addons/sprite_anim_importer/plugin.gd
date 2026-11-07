@tool
extends EditorPlugin

var panel
var inspector_plugin

func _enter_tree():
	panel = preload("res://addons/sprite_anim_importer/import_panel.gd").new()
	add_control_to_container(CONTAINER_INSPECTOR_BOTTOM, panel)

	panel.plugin = self
	panel.visible = false
	
	inspector_plugin = preload("res://addons/sprite_anim_importer/inspector_plugin.gd").new()
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_control_from_container(CONTAINER_INSPECTOR_BOTTOM, panel)
	remove_inspector_plugin(inspector_plugin)
	panel.queue_free()

func _process(delta):
	var selected = get_editor_interface().get_selection().get_selected_nodes()
	if selected.size() == 1 and selected[0] is AnimatedSprite2D:
		panel.set_target(selected[0])
		panel.visible = true
	else:
		panel.visible = false
