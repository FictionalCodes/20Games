class_name PlayerDeadState extends PlayerBaseState


func EnterState() -> void:
	super.EnterState()
	player.freeze = true
	player.visible = false
	player.collisionShape.disabled = true
	

func ExitState() -> void:
	super.ExitState()
	player.freeze = false
	player.visible = true
	player.collisionShape.disabled = false
