class_name Ball extends CharacterBody2D


@export var speed := 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_just_pressed(&"shoot"):
		start(position.direction_to(get_global_mouse_position()))

func start(_direction: Vector2):
	velocity = _direction

func _physics_process(delta):
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

func _on_VisibilityNotifier2D_screen_exited():
	# Deletes the bullet when it exits the screen.
	queue_free()

func exited_screen():
	pass # Replace with function body.
