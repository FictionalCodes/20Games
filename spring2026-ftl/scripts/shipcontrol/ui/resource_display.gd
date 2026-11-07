class_name ResourceDisplay  extends Control

var amount : int = 0:
	get: return amount
	set(val):
		amount = val
		number_display.text = "%s" % amount
		
@export var resource_name : String

@onready var number_display : Label = $Number
@onready var text_show : Label = $TypeLabel

func _ready() -> void:
	text_show.text = resource_name
