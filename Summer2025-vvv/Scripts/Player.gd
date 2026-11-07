class_name Player extends CharacterBody2D

@export var GRAVITY: float = 350.0

@export var speed : float = 200.0
@export var flipBonusSpeedNumber: float = 600
@export var flipBonusSpeedTimer : float = 0.25

@onready var sprite : PlayerAnimator = $Sprite2D

@export var cameraControl : CameraRegionController2D

@export var _respawn_timer: float = 3.0


var currentSpawnPoint : SpawnPoint = null

var respawning : bool = false

@onready var jumpEffectPlayer : AudioStreamPlayer = $JumpEffect
@onready var deathEffectPlayer : AudioStreamPlayer = $DeathEffect
@onready var checkpointEffect : AudioStreamPlayer = $CheckpointEffect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("flip"):
		if is_on_floor():
			flip_gravity()
	if Input.is_action_just_pressed("respawn"):
		start_respawn()
		
func flip_gravity() -> void:
	up_direction *= -1
	sprite.sort_flip_dir(up_direction)
	sprite.do_jump_anim()
	flipBoostTime = 0.0
	jumpEffectPlayer.play()

func set_up(dir: Vector2) -> void:
	up_direction = dir
	sprite.sort_flip_dir(up_direction)



var flipBoostTime = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if flipBoostTime < flipBonusSpeedTimer:
		flipBoostTime += delta
		clampf(flipBoostTime, 0, flipBonusSpeedTimer)
	if !respawning:
		var leftRight := Input.get_axis("left", "right") * speed
		var fallSpeed = clampf(lerpf(flipBonusSpeedNumber, GRAVITY, flipBoostTime/flipBonusSpeedTimer), GRAVITY, flipBonusSpeedNumber)
		velocity = Vector2(leftRight, fallSpeed * -up_direction.y)
		move_and_slide()
		sprite.do_animation_update(velocity)


func _on_kill_area_body_entered(body: Node2D) -> void:
	start_respawn()
	
func start_respawn() -> void:
	_do_respawn.call_deferred()
	respawning = true
	sprite.go_to_death()
	deathEffectPlayer.play()


func _interactable_enter(area: Area2D) -> void:
	if area is SpawnPoint and area != currentSpawnPoint:
		if currentSpawnPoint != null:
			currentSpawnPoint.deactivate()
		currentSpawnPoint = area as SpawnPoint
		currentSpawnPoint.activate()
		checkpointEffect.play()
		
func _do_respawn() -> void:
	await get_tree().create_timer(_respawn_timer).timeout
	set_up(currentSpawnPoint.gravityDir)
	global_position = currentSpawnPoint.global_position
	respawning = false
