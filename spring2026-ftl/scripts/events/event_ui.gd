class_name EventUI extends Control

## doc comment

# @export variables
@export var dialogue_box: VBoxContainer ## It's a box. For dialogue.

# remaining regular variables
var event_id : int
var event : Event


func _ready() -> void:
	event = EventLoader.events[event_id]
	_setup_event()


## Set up the event text and dialogue options
func _setup_event() -> void:
	_set_event_text(event.event_dialogue)
	_set_event_dialogue_options(event.event_dialogue_options)


## Set the event's text
func _set_event_text(text : Array[String]) -> void:
	for text_line in text:
		var label = RichTextLabel.new()
		label.text = text_line
		label.fit_content = true
		label.bbcode_enabled = true
		dialogue_box.add_child(label)


## Set the event's dialogue options
func _set_event_dialogue_options(options : Array) -> void:
	for option in options:
		var hbox = HBoxContainer.new()
		dialogue_box.add_child(hbox)
		var button = Button.new()
		button.text = option.get("OptionText")
		button.pressed.connect(_show_dialogue_outcome.bind(option.get("Outcomes")))
		hbox.add_child(button)
		
		var option_cost = option.get("OptionCost")
		for cost in option_cost:
			var type = cost.get("Type")
			var amount = cost.get("Amount")
			var texture_rect = TextureRect.new()
			var texture
			match type: # TODO: Should probably have some global enum to help with types
				"F": texture = preload("uid://n4y7l6v8lvo6")
				"S": texture = preload("uid://bwsf5qdwgjdh0")
			texture_rect.texture = texture 
			texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			texture_rect.custom_minimum_size = Vector2(16,16)
			hbox.add_child(texture_rect)
		
			## Add the resource value
			var label = Label.new()
			label.text = str(int(amount))
			hbox.add_child(label)


func _show_dialogue_outcome(outcomes : Array) -> void:
	var outcome = outcomes.pick_random()
	var label = RichTextLabel.new()
	label.text = outcome.get("OutcomeText")
	label.fit_content = true
	label.bbcode_enabled = true
	dialogue_box.add_child(label)
	
	var button = Button.new()
	button.text = "Continue..."
	button.pressed.connect(_exit_event)
	dialogue_box.add_child(button)


func _exit_event() -> void:
	queue_free()
