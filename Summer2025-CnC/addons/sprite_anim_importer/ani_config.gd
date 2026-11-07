extends Resource
class_name AnimConfig

@export var texture: Texture2D
@export var frame_width: int = 16
@export var frame_height: int = 16
@export var columns: int = 4
@export var rows: int = 4
@export var duration: float = 1.0
@export var anim_prefix: String = "idle"
@export var row_ani_names: Array[String] = ["down", "left", "right", "up", "down_left", "down_right", "up_right", "up_left"]
