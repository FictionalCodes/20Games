class_name Paddle extends CharacterBody2D


@export var paddle_speed = 1200.0
@export var _ball : Ball

@onready var ballPos : Node2D = $BallLockPosition
@onready var shape: CollisionPolygon2D = $CollisionShape2D as CollisionPolygon2D

func _physics_process(delta: float):
	var target_position = get_global_mouse_position()
	var moveResult = global_position.x - move_toward(global_position.x, target_position.x, paddle_speed * delta)

	var moveVector := Vector2(-moveResult,0)
	move_and_collide(moveVector, false, 1.0)
	if _ball.locked:
		_ball.global_position = ballPos.global_position

