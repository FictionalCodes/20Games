class_name MenuOverlay extends Overlay

@export var menuTypeLabel : Label
@export var scoreNameLabel : Label
@export var resumeButton : Button
@export var startGameButton : Button

enum MenuType {
	MainMenu,
	Pause,
	GameOver
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_menu(MenuType.MainMenu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_menu(type: MenuType) -> void:
	
	var showScore = score != 0
	scoreNameLabel.visible = showScore
	ScoreLabel.visible = showScore
	
	resumeButton.visible = false
	menuTypeLabel.visible = type != MenuType.MainMenu
	match type:
		MenuType.MainMenu:
			startGameButton.text = "Start Game"

			await start_fade()
			
		MenuType.Pause:
			resumeButton.visible = true
			startGameButton.text = "Retry"
			menuTypeLabel.text = "Paused"
			set_visible_immediate()
			
		MenuType.GameOver:
			menuTypeLabel.text = "Game Over"
			startGameButton.text = "New Game"

			await start_fade()
