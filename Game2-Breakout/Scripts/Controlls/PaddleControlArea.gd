class_name PaddleControlArea extends Area2D


@onready var _paddle: Paddle = $Paddle as Paddle

@onready var touch_area: Rect2 = $CollisionShape2D.shape.get_rect()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"shoot"):
		_paddle.shoot(_event.position)

func _draw():
	draw_line(touch_area.position, Vector2(touch_area.position.x + touch_area.size.x, touch_area.position.y), Color.RED, 3.0)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag or event is InputEventMouseMotion:

		var testPos = to_local(event.position)
		if touch_area.has_point(testPos):
			if event is InputEventScreenTouch:
				_paddle.shoot(testPos)

			if event is InputEventScreenDrag or event is InputEventMouseMotion:
				_paddle.setTargetPosition(testPos)
		else:
			print(touch_area, testPos, event.position)
