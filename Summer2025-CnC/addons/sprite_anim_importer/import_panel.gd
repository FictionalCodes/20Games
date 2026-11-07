@tool
extends VBoxContainer

var plugin
var target: AnimatedSprite2D
var folded := false

@onready var fold_button := Button.new()
@onready var content := VBoxContainer.new()
@onready var import_button := Button.new()

@onready var ani_config: AnimConfig = load("res://addons/sprite_anim_importer/ani_config.tres")

func _ready():
	self.name = "Sprite Animation Importer"
	self.custom_minimum_size = Vector2(0, 200)

	fold_button.text = "▼ Sprite Animation Importer"
	fold_button.pressed.connect(_on_fold_pressed)
	add_child(fold_button)

	content.visible = true
	add_child(content)
	
	get_inspector()
	
	import_button = Button.new()
	import_button.text = "Import Animation"
	import_button.pressed.connect(_on_import_pressed)
	content.add_child(import_button)

func get_inspector() -> EditorInspector:
	var inspector := EditorInspector.new()
	inspector.edit(ani_config)
	inspector.size_flags_vertical = Control.SIZE_EXPAND_FILL
	inspector.custom_minimum_size = Vector2(0, 260)
	content.add_child(inspector)
	return inspector

func _on_fold_pressed():
	folded = !folded
	content.visible = not folded
	fold_button.text ="▼ Sprite Animation Importer"
	if folded:
		fold_button.text = "▶ Sprite Animation Importer"

func set_target(node: AnimatedSprite2D):
	target = node

func _on_import_pressed():
	if not target:
		push_error("The AnimatedSprite2D node is not selected.")
		return

	if not ani_config.texture or not ani_config.texture is Texture2D:
		push_error("Invalid texture")
		return

	if target.get_sprite_frames() == null:
		target.set_sprite_frames(SpriteFrames.new())

	print(ani_config.row_ani_names)
	for row_index in range(ani_config.row_ani_names.size()):
		var row_name = ani_config.row_ani_names[row_index]
		var anim_name = "%s_%s" % [ani_config.anim_prefix, row_name]
		
		target.sprite_frames.remove_animation(anim_name)
		target.sprite_frames.add_animation(anim_name)

		for col in range(ani_config.columns):
			var x = col * ani_config.frame_width
			var y = row_index * ani_config.frame_height
			var region = Rect2(x, y, ani_config.frame_width, ani_config.frame_height)
			var atlas_tex = AtlasTexture.new()
			atlas_tex.atlas = ani_config.texture
			atlas_tex.region = region
			target.sprite_frames.add_frame(anim_name, atlas_tex, ani_config.duration, col)

		print("Importing animation: %s, total %d frames" % [anim_name, ani_config.columns])
