extends AnimatableBody2D


@export var paddle_speed = 1200.0

func _physics_process(delta: float):
	var target_position = get_global_mouse_position()
	global_position.x = move_toward(global_position.x, target_position.x, paddle_speed*delta)
