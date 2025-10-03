extends Control

func _ready():
	$Start_Game.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
	self.hide()  # Hides the entire splash screen
	
