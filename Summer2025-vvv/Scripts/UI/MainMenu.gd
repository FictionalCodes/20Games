extends PanelContainer

@export var firstLevel : PackedScene


func load_level() -> void:
	get_tree().change_scene_to_packed(firstLevel)
