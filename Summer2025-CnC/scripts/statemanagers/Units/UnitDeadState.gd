class_name UnitDeadState extends UnitBaseState

@export var removalTimer := 3.0

func EnterState() -> void:
	super.EnterState()
	unit.modulate = Color.RED
	await get_tree().create_timer(removalTimer, false)
	unit.queue_free()
	

func can_be_hurt() -> bool:
	return false

func can_shoot() -> bool:
	return false
