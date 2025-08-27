class_name PlayerAnimator extends AnimatedSprite2D

const runanim := &"run"
const deathanim := &"death"
const idleanim := &"idle"
const jumpanim := &"jump"

var _lock_animation = false

func do_animation_update(motion: Vector2) -> void:
	if _lock_animation: return
	
	if motion.is_zero_approx():
		animation = idleanim
	elif !is_zero_approx(motion.x):
		animation = runanim
		flip_h = motion.x < 0


func do_jump_anim() -> void:
	flip_v = !flip_v
	animation = jumpanim
