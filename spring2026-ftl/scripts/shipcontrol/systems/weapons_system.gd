class_name WeaponSystem extends ShipSystemToggle

var weapons : Array[ShipWeapon] = []

func update(delta: float) -> void:
	for w : ShipWeapon in weapons:
		w.update(delta)
	
	
func jumped() -> void:
	for w : ShipWeapon in weapons:
		w.charge_amount = 0
	
