@tool
class_name StackedSprite extends Sprite2D

@export_category("Drawing Params")
@export var show_sprites := false
@export var auto_rotate := false

@export var frame_start := 0:
	set(value):
		frame_start = clampi(value, 0, hframes + vframes)

@export var frame_end := hframes + vframes:
	set(value):
		frame_end = clampi(value, 0, (hframes + vframes) -1)

@export var layer_seperation : int = 1

@export_category("Game Active Params")
@export var stack_rotation: float:
	set(value):
		stack_rotation = value
		update_stack_rotation(stack_rotation)
		
@export_tool_button("Regen Stack") 
var regenStack = create_layers

var _stack_layers: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_layers()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if auto_rotate:
		stack_rotation += delta
		
func update_stack_rotation(new_rotation: float) -> void:
	for sprite: Sprite2D in _stack_layers:
		sprite.rotation = new_rotation

	
func create_layers() -> void:
	clear_layers()
	for i in range(frame_start, frame_end):
		var next_sprite = Sprite2D.new()
		next_sprite.texture = texture
		next_sprite.hframes = hframes
		next_sprite.vframes = vframes
		next_sprite.frame = i
		next_sprite.position.y = -layer_seperation * i
		next_sprite.rotation = stack_rotation
		add_child(next_sprite)
		_stack_layers.push_back(next_sprite)
		
func clear_layers():
	for sprite: Sprite2D in _stack_layers:
		sprite.queue_free()
	
	_stack_layers.clear()
