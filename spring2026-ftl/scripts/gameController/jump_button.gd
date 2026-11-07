extends Button

# Export Variables
@export var game_controller : GameController


func _ready() -> void:
	pressed.connect(game_controller.toggle_beacon_map_visible)
