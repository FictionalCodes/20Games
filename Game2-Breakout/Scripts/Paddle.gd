class_name Paddle extends CharacterBody2D


@export var paddle_speed = 1200.0
@export var _ball : Ball

@onready var ballPos : Node2D = $BallLockPosition
@onready var shape: CollisionPolygon2D = $CollisionShape2D as CollisionPolygon2D

var _targetPosition:= Vector2.ZERO

func shoot(targetPosition : Vector2) -> void:
	if _ball.locked:
		var shootDir := Vector2.from_angle(get_angle_to(targetPosition))
		_ball.start(shootDir)
	

func setTargetPosition(localPos: Vector2) -> void:
	_targetPosition = localPos

func _physics_process(delta: float):
	var moveResult = position.x - move_toward(position.x, _targetPosition.x, paddle_speed * delta)

	var moveVector := Vector2(-moveResult,0)
	move_and_collide(moveVector, false, 1.0)
	if _ball.locked:
		_ball.global_position = ballPos.global_position

