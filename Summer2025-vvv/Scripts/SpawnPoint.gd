class_name SpawnPoint extends Area2D

@export var inactiveTexture : Texture2D
@export var activeTexture : Texture2D

@onready var sprite : Sprite2D = $Sprite2D

@export var gravityDir := Vector2.UP

	
func deactivate() -> void:
	sprite.texture = inactiveTexture

func activate() -> void:
	sprite.texture = activeTexture
