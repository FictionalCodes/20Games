class_name PlayerThruster extends Marker2D


@onready var animation: AnimatedSprite2D = $ThrustForward
@onready var particles: CPUParticles2D = $ThrustForwardParticles

@export var thrusting:bool = false:
	get: return thrusting
	set(value):
		if value != thrusting:
			set_on_off(value)
		thrusting = value
		

func set_on_off(onOff: bool) -> void:
	animation.visible = onOff
	particles.emitting = onOff
