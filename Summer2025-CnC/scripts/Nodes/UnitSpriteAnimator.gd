class_name UnitSpriteAnimator
extends AnimationTree

var blend :AnimationNodeBlendSpace2D

@export var look_toward_angle : float = 0.0:
	set(value):
		look_toward_angle = value
		set_blend_angle(Vector2.from_angle(-value))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blend = tree_root as AnimationNodeBlendSpace2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
const blendPosPropName := &"parameters/blend_position"	
func set_blend_angle(v: Vector2) -> void:
	set(blendPosPropName, v)		
