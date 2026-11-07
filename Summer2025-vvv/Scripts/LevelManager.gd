class_name LevelManager extends Node2D

@export var player : Player
@export var cameraControl : CameraRegionController2D
@export var pause_things : Array[Node]

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()
		
func toggle_pause() -> void:
	var newValue = !get_tree().paused
	get_tree().paused = newValue
	for item: Node in pause_things:
		item.visible = newValue
