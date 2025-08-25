@tool
class_name AnimateableBody extends AnimatedSprite2D

@export_category("Raw Texture Settings")
@export var texture : Texture2D
@export var numCols : int = 24
@export_tool_button("Make Normal Rotation Sprite") var basic = _import_base_directions

@export_category("Animator Tools")
@export var animationLibary: AnimationLibrary
@export var animationTree: AnimationNodeBlendSpace2D
##THIS WILL WIPE YOUR EXISTING LIBARY
@export var setupPlayer : bool = false
##THIS WILL WIPE YOUR EXISTING TREE
@export var setupAnimationTree : bool = false

@export_category("In Game Settings")
var lookDir := Vector2.ZERO

@onready var animationHelper := $AnimationTree as UnitSpriteAnimator

func _process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	
	animationHelper.look_toward_angle = lookDir.angle() 
	
	

func _import_base_directions() -> void:
	if not Engine.is_editor_hint(): return
	
	var raw_size := texture.get_size()
	raw_size.x /= numCols
	
	sprite_frames = SpriteFrames.new()
	sprite_frames.resource_scene_unique_id = SpriteFrames.generate_scene_unique_id()
		
	sprite_frames.clear_all()
	
	if setupPlayer:
		for anim in animationLibary.get_animation_list():
			animationLibary.remove_animation(anim)

	if setupAnimationTree:
		while animationTree.get_blend_point_count() > 0:
			animationTree.remove_blend_point(0)

	
	for i in numCols:
		var currentPos := Vector2.ZERO
		currentPos.x = i * raw_size.x
		var rect := Rect2(currentPos, raw_size)
		
		var atlas_tex = AtlasTexture.new()
		atlas_tex.atlas = texture
		atlas_tex.region = rect
		var animationName := StringName(String.num_int64(i).pad_zeros(2))
		sprite_frames.add_animation(animationName)
		sprite_frames.add_frame(animationName, atlas_tex)

		if setupPlayer:
			var newAnimation := Animation.new()
			newAnimation.length = 0.1
			var trackIndex := newAnimation.add_track(Animation.TYPE_VALUE)
			newAnimation.track_set_path(trackIndex, NodePath(animationPropPath))
			newAnimation.track_insert_key(trackIndex, 0.0, animationName)
			animationLibary.add_animation(animationName,newAnimation)
			
			if setupAnimationTree:

				var angle := (TAU / numCols) * i
				var animationRoot = AnimationNodeAnimation.new()
				animationRoot.animation = (animationLibary.resource_path.get_file().get_slice(".",0) +"/"+ animationName)

				var realAngle = Vector2.from_angle(angle)
				realAngle.y *= -1
				animationTree.add_blend_point(animationRoot, realAngle)

const animationPropPath = ".:animation"
