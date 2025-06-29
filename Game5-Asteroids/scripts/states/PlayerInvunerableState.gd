class_name PlayerInvunerableState extends PlayerActiveState

@export var invunTime := 3.0
@export var flashIntervalMin:= 0.1
@export var flashIntervalMax:= 0.5

var invunTimer := 0.0

func EnterState() -> void:
	invunTimer = invunTime
	super.EnterState()
	player.set_collision_mask_value(2, false)
	player.modulate = Color.RED
	flashTimer = flashIntervalMax

func ExitState() -> void:
	super.ExitState()
	player.set_collision_mask_value(2, true)
	player.modulate = Color.WHITE
	player.visible = true

var flashTimer = 0.0
func Update(delta: float) -> int:
	invunTimer -= delta
	var lerpAmount = invunTimer/invunTime
	player.modulate = player.normalColour.lerp(player.invunerableModulate, lerpAmount)
	
	flashTimer += delta
	if flashTimer > lerpf(flashIntervalMax, flashIntervalMin, lerpAmount):
		player.visible = !player.visible
	
	if invunTimer < 0.0:
		return PlayerState.Alive
		
	return ThisState
