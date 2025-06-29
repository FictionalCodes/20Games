class_name StarBackground
extends ParallaxBackground


@export var focusObject : RigidBody2D

func _physics_process(delta: float) -> void:
	scroll_offset -= focusObject.linear_velocity * delta
