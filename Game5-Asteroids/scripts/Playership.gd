class_name PlayerShip extends ScreenWrapObject


@export var SPEED := 1000.0
@export var turnSpeed := 500.0

@export var lazer : PackedScene
@export var lazerCooldown : float = 0.2

@export var damageTexture75 : Texture2D
@export var damageTexture50 : Texture2D
@export var damageTexture25 : Texture2D

@onready var thrustAmount := Vector2.UP * SPEED
@onready var lazerSpawn := $ShotMarker

@onready var collisionShape : CollisionPolygon2D = $CollisionShape2D
@onready var stateMachine : PlayerStateMachine = $PlayerStateMachine
@onready var pewpewnoises : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var damageOverlay : Sprite2D = $PlayerShip3Blue/DamageSprite 
@onready var lazerShootEffect: AnimatedSprite2D = $ShotMarker/LazerFire
@onready var forwardThrust: PlayerThruster = $ForwardThrust
@onready var leftThrust: PlayerThruster = $LeftThrust
@onready var rightThrust: PlayerThruster = $RIghtThrust
@export var playerHealthMax: int = 5



signal playerHurt(newHP: int)
signal playerDead

@export var invunerableModulate: Color
@onready var normalColour:= modulate

@onready var playerHealthCurrent: int = playerHealthMax
	
func _integrate_forces(state):
	var thrustDir := Input.get_axis("thrust_reverse","thrust_forward");
	if thrustDir != 0.0:
		state.apply_central_force(thrustAmount.rotated(rotation) * thrustDir)
	
	forwardThrust.thrusting = thrustDir > 0.0
	
	
	var rotation_direction = 0
	var rotationDir = Input.get_axis("turn_left", "turn_right")
	
	leftThrust.thrusting = rotationDir < 0.0
	rightThrust.thrusting = rotationDir > 0.0

	state.apply_torque(rotationDir * turnSpeed)
	
var lazerTimer = lazerCooldown
func _process(delta: float) -> void:
	
	lazerTimer -= delta
	if(stateMachine.currentState.can_shoot()  and lazerTimer < 0.0 and Input.is_action_pressed("shoot")):
		shoot_lazer()
		lazerTimer = lazerCooldown

		
func shoot_lazer() -> void:
	var direction := Vector2(lazerSpawn.global_position - global_position).normalized()
	var created := lazer.instantiate() as Laser
	created.global_position = lazerSpawn.global_position
	lazerShootEffect.play()
	created.shoot(direction)
	get_parent().add_child(created)
	pewpewnoises.play()

func reset() ->void:
	playerHealthCurrent = playerHealthMax
	damage_visual_update()
	stateMachine.QueueSwapState(PlayerBaseState.PlayerState.Alive)

func Respawn(position: Vector2) -> void:
	playerHealthCurrent = playerHealthMax
	JumpToPosition(position)
	stateMachine.QueueSwapState(PlayerBaseState.PlayerState.Respawning)
	
func JumpToPosition(position: Vector2) -> void:
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	global_position = position
	rotation = Vector2.UP.angle()



func _on_body_entered(body: Node) -> void:
	
	if stateMachine.currentState.can_be_hurt():
		playerHealthCurrent -= 1
		damage_visual_update()

		playerHurt.emit(playerHealthCurrent)
		if playerHealthCurrent <= 0:
			playerDead.emit()
			stateMachine.QueueSwapState(PlayerBaseState.PlayerState.Dead)
		else:	
			stateMachine.QueueSwapState(PlayerBaseState.PlayerState.Invunerable)
	
func damage_visual_update() -> void:
	if playerHealthCurrent >= playerHealthMax:
		damageOverlay.visible = false
	else:
		damageOverlay.visible = true
		var healthPercentage := float(playerHealthCurrent) / float(playerHealthMax)
		match healthPercentage:
			var x when x < 0.25:
				damageOverlay.texture = damageTexture25
			var x when x < 0.50:
				damageOverlay.texture = damageTexture50
			var x when x< 0.75:
				damageOverlay.texture = damageTexture75
			var x when x > 0.75:
				damageOverlay.visible = false

func set_invun(on: bool) -> void:
	set_collision_mask_value(2, on)
	modulate = Color.RED if on else normalColour
