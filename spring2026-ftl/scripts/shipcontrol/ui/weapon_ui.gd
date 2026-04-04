class_name WeaponUI extends Control

@onready var powerText : Label = $PowerNeeded
@onready var weaponName : Label = $WeaponName
@onready var onButton : CheckButton = $WeaponPowerTogglwe
@onready var chargebar : ProgressBar = $Charge

var _weapon : ShipWeapon

func initalise(weapon: ShipWeapon) -> void:
	_weapon = weapon
	powerText.text = "Power Needed - %s" % weapon.weapon_data.power_use
	_weapon.update_ui.connect(_update_display, ConnectFlags.CONNECT_DEFERRED)
	

func _update_display(weapon: ShipWeapon) -> void:
	weaponName.text = weapon.weapon_data.name
	powerText.text = "Power Needed - %s" % weapon.weapon_data.power_use
	onButton.set_pressed_no_signal(weapon.active)
	chargebar.set_value_no_signal(weapon.charge_amount)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouseButtonEvent = event as InputEventMouseButton
		if !mouseButtonEvent.pressed:
			return
		match mouseButtonEvent.button_index:
			MouseButton.MOUSE_BUTTON_LEFT:
				if _weapon.active:
					pass
				else:
					_weapon.active = true
				
			MouseButton.MOUSE_BUTTON_RIGHT:
				_weapon.active = false
			_:
				return
