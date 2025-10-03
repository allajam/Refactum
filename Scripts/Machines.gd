extends Control

# Buttons cached at the top
@onready var collector_btn = $MachineBG/ScrollContainer/VBoxContainer/CollectionBtn
@onready var shredder_btn  = $MachineBG/ScrollContainer/VBoxContainer/ShredderBtn
@onready var washer_btn    = $MachineBG/ScrollContainer/VBoxContainer/WasherBtn
@onready var _____    = $MachineBG/ScrollContainer/VBoxContainer/SorterBtn
@onready var __    = $MachineBG/ScrollContainer/VBoxContainer/ExtruderBtn
@onready var ___    = $MachineBG/ScrollContainer/VBoxContainer/MarketBtn

# add more as needed...

func _ready() -> void:
	# Connect signals (Godot 4.x style)
	collector_btn.pressed.connect(func(): _on_machine_button_pressed("Collector"))
	shredder_btn.pressed.connect(func(): _on_machine_button_pressed("Shredder"))
	washer_btn.pressed.connect(func(): _on_machine_button_pressed("Washer"))

	update_ui()

func _on_machine_button_pressed(machine_name: String) -> void:
	var cost = GameManager.get_upgrade_cost(machine_name)
	if GameManager.coins >= cost:
		GameManager.coins -= cost
		GameManager.machines[machine_name].level += 1
		update_ui()
	else:
		print("Not enough coins to upgrade ", machine_name)

func update_ui() -> void:
	collector_btn.text = "Collector (Lv.%d)\nUpgrade: %d coins" % [
		GameManager.machines["Collector"].level,
		GameManager.get_upgrade_cost("Collector")
	]
	shredder_btn.text = "Shredder (Lv.%d)\nUpgrade: %d coins" % [
		GameManager.machines["Shredder"].level,
		GameManager.get_upgrade_cost("Shredder")
	]
	washer_btn.text = "Washer (Lv.%d)\nUpgrade: %d coins" % [
		GameManager.machines["Washer"].level,
		GameManager.get_upgrade_cost("Washer")
	]
