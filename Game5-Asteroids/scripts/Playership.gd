class_name PlayerShip extends ScreenWrapObject


@export var SPEED := 1000.0
@export var turnSpeed := 500.0

@export var lazer : PackedScene
@export var lazerCooldown : float = 0.2

@onready var thrustAmount := Vector2.UP * SPEED
@onready var lazerSpawn := $ShotMarker

@onready var collisionShape : CollisionPolygon2D = $CollisionShape2D
@onready var stateMachine : PlayerStateMachine = $PlayerStateMachine

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
	var rotation_direction = 0
	var rotationDir = Input.get_axis("turn_left", "turn_right")
	state.apply_torque(rotationDir * turnSpeed)
	
var lazerTimer = lazerCooldown
func _process(delta: float) -> void:
	
	lazerTimer -= delta
	if(stateMachine.currentStateIndex == PlayerBaseState.PlayerState.Alive and lazerTimer < 0.0 and Input.is_action_pressed("shoot")):
		var direction := Vector2(lazerSpawn.global_position - global_position).normalized()
		var created := lazer.instantiate() as Laser
		created.global_position = lazerSpawn.global_position
		created.shoot(direction)
		get_parent().add_child(created)
		
		lazerTimer = lazerCooldown


func Respawn(position: Vector2) -> void:
	playerHealthCurrent = playerHealthMax
	JumpToPosition(position)
	stateMachine.QueueSwapState(PlayerBaseState.PlayerState.Respawning)
	
func JumpToPosition(position: Vector2) -> void:
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	global_position = position



func _on_body_entered(body: Node) -> void:
	
	if stateMachine.currentState.can_be_hurt():
		playerHealthCurrent -= 1
		playerHurt.emit(playerHealthCurrent)
		if playerHealthCurrent <= 0:
			playerDead.emit()
			stateMachine.QueueSwapState(PlayerBaseState.PlayerState.Dead)
		else:	
			stateMachine.QueueSwapState(PlayerBaseState.PlayerState.Invunerable)
	
func set_invun(on: bool) -> void:
	set_collision_mask_value(2, on)
	modulate = Color.RED if on else normalColour
