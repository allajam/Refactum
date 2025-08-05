extends Node2D 

@onready var pause_menu = $PauseMenu 

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if pause_menu.visible:
			pause_menu.hide_menu()
			
		else:
			pause_menu.show_menu()
	if event.is_action_pressed("leftclick"):
		AudioManager.play_click()
		global_gold.money += 10
		AudioManager.play_bgm()

func _ready():
	global_gold.money = 500


