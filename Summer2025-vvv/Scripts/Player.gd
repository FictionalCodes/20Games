class_name Player extends CharacterBody2D

@export var GRAVITY: float = 350.0

@export var speed : float = 200.0
@export var flipBonusSpeedNumber: float = 600
@export var flipBonusSpeedTimer : float = 0.25

@onready var sprite : PlayerAnimator = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("flip"):
		if is_on_floor_only():
			flip_gravity()
		
func flip_gravity() -> void:
	up_direction *= -1
	sprite.do_jump_anim()
	flipBoostTime = 0.0

var flipBoostTime = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if flipBoostTime < 1.0:
		flipBoostTime += delta
	var leftRight := Input.get_axis("left", "right") * speed
	var fallSpeed = clampf(lerpf(flipBonusSpeedNumber, GRAVITY, flipBoostTime/flipBonusSpeedTimer), GRAVITY, flipBonusSpeedNumber)
	velocity = Vector2(leftRight, fallSpeed * -up_direction.y)
	move_and_slide()
	sprite.do_animation_update(velocity)


func _on_kill_area_body_entered(body: Node2D) -> void:
	modulate = Color.RED
