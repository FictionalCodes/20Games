class_name PathFollower extends PathFollow2D

@export var speed := 10.0
@export var flipflop : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


@onready var forward := true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if flipflop:
		if forward:
			progress += speed * delta
			forward = !is_equal_approx(progress_ratio, 1.0)
		else:
			progress -= speed * delta
			forward = is_equal_approx(progress_ratio, 0.0)
	else:
		progress += speed * delta
