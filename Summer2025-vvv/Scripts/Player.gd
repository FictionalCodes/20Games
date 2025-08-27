class_name Player extends CharacterBody2D

const GRAVITY: float = 400.0

@export var speed : float = 200.0

@onready var sprite : AnimatedSprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("flip"):
		if is_on_floor_only():
			flip_gravity()
		
func flip_gravity() -> void:
	up_direction *= -1
	sprite.flip_v = !sprite.flip_v

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	var leftRight := Input.get_axis("left", "right") * speed
	
	velocity = Vector2(leftRight, GRAVITY * -up_direction.y)
	move_and_slide()


func _on_kill_area_body_entered(body: Node2D) -> void:
	modulate = Color.RED
