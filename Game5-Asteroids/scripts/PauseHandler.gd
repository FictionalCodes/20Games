class_name PauseHandler
extends Node2D


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused
	get_parent().set_paused(get_tree().paused)

func set_paused(paused: bool) -> void:
	get_tree().paused = paused
	get_parent().set_paused(paused)
