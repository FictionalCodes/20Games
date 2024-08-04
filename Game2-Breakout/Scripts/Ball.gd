class_name Ball extends CharacterBody2D


@export var speed := 300.0
@export var _playerPaddle : AnimatableBody2D

@onready var _trail : Line2D = $Trail2D

var locked: bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal PlayerDeath()

func _process(delta):
	if Input.is_action_just_pressed(&"shoot"):
		start(position.direction_to(get_global_mouse_position()))

func start(_direction: Vector2):
	velocity = _direction
	locked = false
	_trail.clear_points()
	_trail.visible = true

	

func _physics_process(delta):
	if locked: return

	var collision := move_and_collide(velocity * speed * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		var other := collision.get_collider()

		if other.has_method("on_hit"):
			other.on_hit()

		var originalAngleOfBall := rad_to_deg(Vector2.ZERO.angle_to_point(velocity.abs().normalized()))
		var angleToUpdateTo := clampf(originalAngleOfBall, 30.0, 65.0)
		var deg_adjust = angleToUpdateTo - originalAngleOfBall
		var adjustment := deg_to_rad(deg_adjust)
		print([originalAngleOfBall, angleToUpdateTo, deg_adjust])
		var originalVelocity = velocity
		velocity = velocity.rotated(adjustment)
		print(originalVelocity, velocity)


func exited_screen():
	locked = true
	_trail.visible = false
	PlayerDeath.emit()
