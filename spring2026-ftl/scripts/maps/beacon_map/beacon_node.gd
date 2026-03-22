class_name BeaconNode extends Node2D

## doc comment

#signals
#enums
# constants
# static variables
# @export variables
# remaining regular variables
# @onready variables
@onready var node_texture: TextureRect = %NodeTexture
@onready var tooltip: PanelContainer = %Tooltip
@onready var area: Area2D = $Area2D


func _ready() -> void:
	_connect_signals()
	_set_label_text()
	tooltip.hide()
	area.hide()


func _connect_signals() -> void:
	node_texture.mouse_entered.connect(_on_mouse_entered)
	node_texture.mouse_exited.connect(_on_mouse_exited)
	area.body_entered.connect(_on_body_entered)


func _set_label_text() -> void:
	%DescriptionLabel.text = 'An unexplored location'


func _on_mouse_entered() -> void:
	tooltip.show()


func _on_mouse_exited() -> void:
	tooltip.hide()


func _on_body_entered(body) -> void:
	print(body)
