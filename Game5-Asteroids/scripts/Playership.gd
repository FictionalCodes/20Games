class_name PlayerShip extends ScreenWrapObject


@export var SPEED := 1000.0
@export var turnSpeed := 500.0

@onready var thrustAmount = Vector2.UP * SPEED


	
func _integrate_forces(state):
	var thrustDir := Input.get_axis("thrust_reverse","thrust_forward");
	if thrustDir != 0.0:
		state.apply_central_force(thrustAmount.rotated(rotation) * thrustDir)
	var rotation_direction = 0
	var rotationDir = Input.get_axis("turn_left", "turn_right")
	state.apply_torque(rotationDir * turnSpeed)
	
	
