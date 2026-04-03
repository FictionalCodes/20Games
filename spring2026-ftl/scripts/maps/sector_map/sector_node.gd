class_name SectorNode extends Node2D

## A Sector Node for the Sector Map. 

# @export variables
@export var node_texture: TextureRect
@export var tooltip: PanelContainer
@export var tooltip_sector_name: Label
@export var tooltip_sector_type: Label
@export var tooltip_description: Label
@export var current_sector_indicator : Polygon2D
@export var click_zone: Area2D

# remaining regular variables
var sector_type : String
var current_sector : bool
var last_sector : bool
var explored : bool
var column : int
var sector_map : SectorMap

func _ready() -> void:
	_connect_signals()
	node_texture.modulate = _get_sector_type_colour()
	_setup_tooltip()


## Connect signals to their events
func _connect_signals() -> void:
	click_zone.mouse_entered.connect(_on_mouse_entered)
	click_zone.mouse_exited.connect(_on_mouse_exited)
	click_zone.input_event.connect(_on_click_zone_input_event)


## Return a colour based on the node's sector type
func _get_sector_type_colour() -> Color:
	var colour : Color
	match sector_type:
		'Civilian': colour = Color.GREEN
		'Hostile': colour = Color.RED
		'Nebula': colour = Color.PURPLE
	return colour


## Set up the tooltip
func _setup_tooltip() -> void:
	tooltip_sector_type.text = sector_type
	tooltip_sector_type.modulate = _get_sector_type_colour()
	if current_sector:
		_set_sector_as_explored()
	tooltip.hide()


func _on_mouse_entered() -> void:
	tooltip.show()


func _on_mouse_exited() -> void:
	tooltip.hide()


func _on_click_zone_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("confirm") and not current_sector and column == sector_map.current_sector_node.column + 1:
		get_tree().call_group("sector_node", "clear_current_sector")
		set_as_current_sector()


func set_as_current_sector() -> void:
	current_sector = true
	current_sector_indicator.show()
	sector_map.current_sector_node = self
	if not explored:
		_set_sector_as_explored()


func clear_current_sector() -> void:
	if current_sector:
		current_sector = false
		current_sector_indicator.hide()


func _set_sector_as_explored() -> void:
	explored = true
	tooltip_sector_name.text = 'Explored Sector'
	tooltip_description.text = 'A region of explored space'
