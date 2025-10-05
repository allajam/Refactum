extends CanvasLayer

@onready var resume_button = $PauseMenu/Resume_But
@onready var help_button = $PauseMenu/Help_But
@onready var quit_button = $PauseMenu/Quit_But
@onready var help_menu = $HelpMenu

func _ready():
	visible = false
	help_menu.visible = false

	resume_button.pressed.connect(_on_resume_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	help_button.pressed.connect(_on_help_pressed)
	$HelpMenu/Back_But.pressed.connect(_on_back_pressed)




func show_menu():
	visible = true
	get_tree().paused = true
	set_process_input(true)
	AudioManager.pause_bgm()

func hide_menu():
	visible = false
	get_tree().paused = false
	set_process_input(false)
	AudioManager.play_bgm()

func _on_resume_pressed():
	hide_menu()

func _on_quit_pressed():
	get_tree().quit()

func _on_help_pressed():
	$PauseMenu.visible = false
	help_menu.visible = true

func _on_back_pressed():
	help_menu.visible = false
	$PauseMenu.visible = true


