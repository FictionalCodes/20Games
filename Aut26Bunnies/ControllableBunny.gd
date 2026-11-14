class_name Bunny extends RigidBody2D

@export var bunny_move_speed : float = 50.0

@export var controlled: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	
	if !controlled:
		pass
	
	var movement = Input.get_axis("left", "right")
	# Vertical movement code. Apply gravity.
	var testVel = state.linear_velocity
	testVel.x = movement * bunny_move_speed
	testVel.y += get_gravity().y

	var collision = move_and_collide(testVel * state.step, false)
	if collision:
		state.linear_velocity = testVel.slide(collision.get_normal())
	
