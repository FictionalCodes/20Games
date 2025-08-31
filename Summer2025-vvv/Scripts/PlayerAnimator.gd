class_name PlayerAnimator extends AnimatedSprite2D

const runanim := &"run"
const deathanim := &"death"
const idleanim := &"idle"
const jumpanim := &"jump"

func do_animation_update(motion: Vector2) -> void:
	if motion.is_zero_approx():
		animation = idleanim
	elif !is_zero_approx(motion.x):
		animation = runanim
		flip_h = motion.x < 0

func do_jump_anim() -> void:
	animation = jumpanim

func sort_flip_dir(dir: Vector2) -> void:
	flip_v = dir == Vector2.DOWN

func go_to_death() -> void:
	animation = deathanim
