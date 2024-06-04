class_name Block extends StaticBody2D

@export var hp := 3
@onready var label :Label = $Label

func on_hit():
	hp -= 1
	if hp <= 0:
		queue_free()
	else:
		label.text = str(hp)