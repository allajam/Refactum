extends Control

@onready var upgrade_menu = $UpgradeBG
@onready var open_button = $Upgrades
@onready var close_button = $UpgradeBG/Exit_Button

func _ready():
	open_button.pressed.connect(_on_open_button_pressed)
	close_button.pressed.connect(_on_close_button_pressed)

	# Start hidden
	upgrade_menu.visible = false
	close_button.visible = false

func _on_open_button_pressed():
	var is_open = upgrade_menu.visible
	upgrade_menu.visible = not is_open
	close_button.visible = not is_open

func _on_close_button_pressed():
	upgrade_menu.visible = false
	close_button.visible = false

