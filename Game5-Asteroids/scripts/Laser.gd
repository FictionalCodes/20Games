class_name Laser extends RigidBody2D

@export var speed : float = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot(direction:Vector2) -> void:
	global_rotation = direction.angle() + PI/2
	linear_velocity = direction * speed


func _on_body_entered(body: Node) -> void:
	queue_free()
