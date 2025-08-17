@tool
extends EditorPlugin

var checkbutton : CheckButton

func _enter_tree() -> void:
	checkbutton = CheckButton.new()
	checkbutton.text = "Lights"
	checkbutton.button_pressed = true
	checkbutton.toggled.connect(toggle_lights)
	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, checkbutton)
	scene_changed.connect(reset_state.unbind(1))


func reset_state():
	checkbutton.button_pressed = true
	get_tree().call_group("___AntiLights", "queue_free")


func toggle_lights(on : bool):
	if on:
		get_tree().call_group("___AntiLights", "queue_free")
	else:
		var editor : EditorInterface = get_editor_interface()
		var root = editor.get_edited_scene_root()
		if is_instance_valid(root):
			add_anti_lights(root)


func add_anti_lights(node : Node) -> void:
	if node is Light2D and node.blend_mode != Light2D.BLEND_MODE_MIX:
		var anti_light : Light2D = node.duplicate(0)
		for child in anti_light.get_children(true):
			child.queue_free()
		if anti_light.blend_mode == Light2D.BLEND_MODE_ADD:
			anti_light.blend_mode = Light2D.BLEND_MODE_SUB
		elif anti_light.blend_mode == Light2D.BLEND_MODE_SUB:
			anti_light.blend_mode = Light2D.BLEND_MODE_ADD
		anti_light.transform = Transform2D.IDENTITY
		anti_light.add_to_group("___AntiLights")
		node.add_child(anti_light, false, Node.INTERNAL_MODE_BACK)
	for child in node.get_children():
		add_anti_lights(child)


func _exit_tree() -> void:
	reset_state()
	remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, checkbutton)
