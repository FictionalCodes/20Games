class_name Asteroid extends ScreenWrapObject

@export var _minSpeed: float = 200.0
@export var _maxSpeed: float = 500.0

@export var _minSpin: float = 20.0
@export var _maxSpin: float = 100.0

@onready var particles: CPUParticles2D = $CPUParticles2D
@onready var explosion: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

@onready var sprite:Sprite2D = $Sprite

enum Size{
	Big = 1,
	Med = 2,
	Small = 3
}
@export var size: Size

var kill_when_leave_screen := false

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
	sprite.visible = false
	kill_when_leave_screen = true
	collision.disabled = true
	start_kill_animation()

func _screenWrapperExited() -> void:
	if kill_when_leave_screen:
		queue_free()
	else: super._screenWrapperExited()
	
func start_kill_animation() -> void:
	particles.emitting = true
	explosion.visible = true
	var animations := Array(explosion.sprite_frames.get_animation_names())
	explosion.play(animations.pick_random())
	
	


func _on_cpu_particles_2d_finished() -> void:
	if !explosion.is_playing() and !particles.emitting:
		queue_free()
