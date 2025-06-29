class_name Asteroid extends ScreenWrapObject

@export var _minSpeed: float = 200.0
@export var _maxSpeed: float = 500.0

@export var _minSpin: float = 20.0
@export var _maxSpin: float = 100.0

enum Size{
	Big = 1,
	Med = 2,
	Small = 3
}
@export var size: Size

var On_kill_callback : Callable:
	get: return On_kill_callback
	set(value): On_kill_callback = value

func yeet(direction: Vector2) -> void:
	linear_velocity = direction * randf_range(_minSpeed, _maxSpeed)
	angular_velocity = randf() * (PI/2) * sign(randf() -0.5)


func yeet_random() ->void:
	var direction = Vector2.from_angle(randf() * TAU)
	linear_velocity = direction * randf_range(_minSpeed, _maxSpeed)
	apply_torque(randf_range(_minSpin, _maxSpin) * sign(randf()-0.5)) 

func _on_body_entered(body: Node) -> void:
	On_kill_callback.call_deferred(self)
	queue_free()

	
