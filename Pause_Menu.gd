extends CanvasLayer

@onready var resume_button = $Control/Resume_But
@onready var quit_button = $Control/Quit_But

func _ready():
	visible = false 
	resume_button.pressed.connect(_on_resume_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func show_menu():
	visible = true

func hide_menu():
	visible = false

func _on_resume_pressed():
	hide_menu()

func _on_quit_pressed():
	get_tree().quit()
