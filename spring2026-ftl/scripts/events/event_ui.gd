class_name EventUI extends Control

## doc comment

#signals
#enums
# constants
# static variables
# @export variables

# remaining regular variables
var event : Event
var event_loader : EventLoader

# @onready variables
@onready var dialogue_box: VBoxContainer = $PanelContainer/MarginContainer/PanelContainer/MarginContainer/DialogueBox
#const CIRCLE_SPRITE = preload("uid://n4y7l6v8lvo6")
#const DIAMOND_SPRITE = preload("uid://bwsf5qdwgjdh0")

func _ready() -> void:
	event_loader = EventLoader.new()
	event = event_loader.events['2']
	_set_text()


func _set_text() -> void:
	# Add event dialogue
	for dialogue in event.event_dialogue:
		var label = RichTextLabel.new()
		label.text = dialogue
		label.fit_content = true
		label.bbcode_enabled = true
		dialogue_box.add_child(label)
	# Add event rewards
	if event.event_rewards:
		var hbox = HBoxContainer.new()
		dialogue_box.add_child(hbox)
		for reward in event.event_rewards:
			
			# Add the resource texture
			var texture_rect = TextureRect.new()
			var texture
			match reward[0]:
				"Fuel": texture = preload("uid://n4y7l6v8lvo6")
				"Scrap": texture = preload("uid://bwsf5qdwgjdh0")
			texture_rect.texture = texture #TODO: update to match on some enum of resource types
			texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			texture_rect.custom_minimum_size = Vector2(16,16)
			hbox.add_child(texture_rect)
			
			# Add the resource value
			var label = Label.new()
			label.text = str(int(reward[1]))
			hbox.add_child(label)
		
	# Add event dialogue options
	for event_choice in event.event_dialogue_options:
		var button = Button.new()
		button.text = event_choice
		dialogue_box.add_child(button)
