class_name PlayerInvunerableState extends PlayerBaseState

@export var invunTime := 3.0
@export var flashIntervalMin:= 0.1
@export var flashIntervalMax:= 0.5
@export var flashItems : Array[Node2D]
@export var modulateItems : Array[Node2D]
var invunTimer := 0.0

func EnterState() -> void:
	invunTimer = invunTime
	super.EnterState()
	player.set_collision_mask_value(2, false)
	flashTimer = flashIntervalMax

func ExitState() -> void:
	super.ExitState()
	player.set_collision_mask_value(2, true)
	for item in modulateItems:
		item.modulate = Color.WHITE
	player.visible = true
	for item in flashItems:
		item.visible = true


var flashTimer = 0.0
func Update(delta: float) -> int:
	invunTimer -= delta
	var lerpAmount = invunTimer/invunTime
	var modulateColour = player.normalColour.lerp(player.invunerableModulate, lerpAmount)
	for item in modulateItems:
		item.modulate = modulateColour

	
	flashTimer += delta
	if flashTimer > lerpf(flashIntervalMax, flashIntervalMin, lerpAmount):
		for item in flashItems:
			item.visible = !item.visible
	
	if invunTimer < 0.0:
		return PlayerState.Alive
		
	return ThisState


func can_shoot() -> bool:
	return true
	
func own_movement() -> bool:
	return true
