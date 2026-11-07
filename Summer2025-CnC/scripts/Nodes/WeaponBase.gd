class_name WeaponBase extends Area2D

@export var weapon_range : float
@export var enagement_range : float:
	set(value):
		enagement_range = clampf(value, 0, weapon_range)
		
@onready var _engagementArea := $EngagementRange.shape as CircleShape2D
@onready var _reloadTimer := $ReloadTimer as Timer

var _shotReady := true

var _scan_targets := false

var _currentTarget: BaseUnit = null
var _priorityTarget: BaseUnit = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process_physics(delta: float) -> void:
	var distance = global_position.distance_to(_priorityTarget.global_position)
	if(distance < weapon_range):
		if _currentTarget != _priorityTarget:
			_currentTarget = _priorityTarget
			
	if _currentTarget == null:
		pass

func find_closest_target() -> void:
	pass

func reloaded() -> void:
	_shotReady = true


func _on_body_entered(body: Node2D) -> void:
	if _currentTarget != null: return
	
	var foundUnit = body as BaseUnit
	if foundUnit == null: return
	_currentTarget = foundUnit
	
func _set_current_target(unit: BaseUnit) -> void:
	if _currentTarget != null:
		_currentTarget.unit_destroyed.disconnect(_target_destroyed)
		
func _target_destroyed(unit: BaseUnit) -> void:
	_currentTarget = null
	
	
