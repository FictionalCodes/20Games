class_name PlayerActiveState extends PlayerBaseState

func Update(delta:float) -> int:
	return ThisState

func can_be_hurt() -> bool:
	return true

func can_shoot() -> bool:
	return true
