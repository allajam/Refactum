extends Node2D  # or your actual root node type

@onready var pause_menu = $PauseMenu  # Update path if needed

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if pause_menu.visible:
			pause_menu.hide_menu()
		else:
			pause_menu.show_menu()
