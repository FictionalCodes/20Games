class_name Ball extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var speed = 750

func _process(delta):
	if Input.is_action_just_pressed(&"shoot"):
		start(position.direction_to(get_global_mouse_position()))

func start(_direction: Vector2):
	velocity = _direction

func _physics_process(delta):
	var collision := move_and_collide(velocity * SPEED * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		var other := collision.get_collider()

		if other.has_method("on_hit"):
			other.on_hit()

func _on_VisibilityNotifier2D_screen_exited():
	# Deletes the bullet when it exits the screen.
	queue_free()