class_name ScreenWrapObject extends RigidBody2D

@onready var screenWrapper := $ScreenWrapper as VisibleOnScreenNotifier2D

func _screenWrapperExited() -> void:
	physics_interpolation_mode = PhysicsInterpolationMode.PHYSICS_INTERPOLATION_MODE_OFF
	
	var viewportSize := get_viewport_rect()
	var halfSpriteSize := screenWrapper.rect.size/2
	if global_position.x < 0 - halfSpriteSize.x:
		global_position.x = viewportSize.end.x + halfSpriteSize.x
	elif global_position.x > viewportSize.end.x + halfSpriteSize.x:
		global_position.x = viewportSize.position.x - halfSpriteSize.x
		
	if global_position.y < 0 - halfSpriteSize.y:
		global_position.y = viewportSize.end.y + halfSpriteSize.y
	elif global_position.y > viewportSize.end.y + halfSpriteSize.y:
		global_position.y = viewportSize.position.y - halfSpriteSize.y
		


func _screenEntered() -> void:
	physics_interpolation_mode = PhysicsInterpolationMode.PHYSICS_INTERPOLATION_MODE_INHERIT
