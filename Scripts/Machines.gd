extends Control

@onready var upgrades_btn = $Button
@onready var machine_menu = $MachineBG
@onready var exit_btn = $MachineBG/ExitButton

# Machine buttons
@onready var collector_btn = $MachineBG/ScrollContainer/VBoxContainer/CollectionBtn
@onready var shredder_btn  = $MachineBG/ScrollContainer/VBoxContainer/ShredderBtn
@onready var washer_btn    = $MachineBG/ScrollContainer/VBoxContainer/WasherBtn
@onready var sorter_btn    = $MachineBG/ScrollContainer/VBoxContainer/SorterBtn
@onready var extruder_btn  = $MachineBG/ScrollContainer/VBoxContainer/ExtruderBtn
@onready var market_btn    = $MachineBG/ScrollContainer/VBoxContainer/MarketBtn

# Labels under each button
@onready var collector_label = collector_btn.get_node("Label")
@onready var shredder_label  = shredder_btn.get_node("Label")
@onready var washer_label    = washer_btn.get_node("Label")
@onready var sorter_label    = sorter_btn.get_node("Label")
@onready var extruder_label  = extruder_btn.get_node("Label")
@onready var market_label    = market_btn.get_node("Label")

# Machine data
var machines = {
	"Collector": {"level": 0, "base_cost": 100, "multiplier": 1.4},
	"Shredder": {"level": 0, "base_cost": 200, "multiplier": 1.5},
	"Washer":   {"level": 0, "base_cost": 300, "multiplier": 1.6},
	"Sorter":   {"level": 0, "base_cost": 400, "multiplier": 1.7},
	"Extruder": {"level": 0, "base_cost": 500, "multiplier": 1.8},
	"Market":   {"level": 0, "base_cost": 600, "multiplier": 1.9}
}

func _ready() -> void:
	# Connect buttons
	collector_btn.pressed.connect(func(): _on_machine_button_pressed("Collector"))
	shredder_btn.pressed.connect(func(): _on_machine_button_pressed("Shredder"))
	washer_btn.pressed.connect(func(): _on_machine_button_pressed("Washer"))
	sorter_btn.pressed.connect(func(): _on_machine_button_pressed("Sorter"))
	extruder_btn.pressed.connect(func(): _on_machine_button_pressed("Extruder"))
	market_btn.pressed.connect(func(): _on_machine_button_pressed("Market"))

	upgrades_btn.pressed.connect(_on_upgrades_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)

	update_ui()
	machine_menu.visible = false

# Show/hide machine menu
func _on_upgrades_pressed() -> void:
	machine_menu.visible = !machine_menu.visible

func _on_exit_pressed() -> void:
	machine_menu.visible = false

# Purchase machine
func _on_machine_button_pressed(machine_name: String) -> void:
	var cost = get_machine_cost(machine_name)
	if global_gold.money >= cost:
		global_gold.money -= cost
		machines[machine_name]["level"] += 1
		print("Bought %s. New level: %d" % [machine_name, machines[machine_name]["level"]])
		update_ui()
		update_machine_panel()
	else:
		print("Not enough gold for %s! Cost: %d" % [machine_name, cost])
		var banner = get_tree().root.get_node("Main/UI/Banner/NotEnoughMoneyBanner")
		banner.show_banner("Not enough gold! Cost: %d" % cost)

# Calculate machine cost
func get_machine_cost(machine_name: String) -> int:
	var data = machines[machine_name]
	return int(data["base_cost"] * pow(data["multiplier"], data["level"]))

# Update all labels
func update_ui() -> void:
	collector_label.text = "%d" % get_machine_cost("Collector")
	shredder_label.text  = "%d" % get_machine_cost("Shredder")
	washer_label.text    = "%d" % get_machine_cost("Washer")
	sorter_label.text    = "%d" % get_machine_cost("Sorter")
	extruder_label.text  = "%d" % get_machine_cost("Extruder")
	market_label.text    = "%d" % get_machine_cost("Market")



###HOVER PANEL FOR Information
# Info Panel
@onready var info_panel = $MachineBG/MachineInfoPanel
@onready var lbl_level = $MachineBG/MachineInfoPanel/Label_Level
@onready var lbl_effect = $MachineBG/MachineInfoPanel/Label_Effect

var current_hovered_button: Button = null
var current_hovered_machine: String = ""

func show_machine_info(machine_name: String, button: Button, update_only: bool=false):
	current_hovered_machine = machine_name
	current_hovered_button = button

	var data = machines[machine_name]
	var level = data["level"]

	# Example effect (adjust as needed)
	var current_effect = level * 1
	var next_effect = (level + 1) * 1

	lbl_level.text = "Level %d → Level %d" % [level, level + 1]
	lbl_effect.text = "%.1f → %.1f" % [current_effect, next_effect]

	if not update_only:
		# Dynamically position panel next to button
		var button_pos = button.get_global_position()
		var button_size = button.get_size()
		
		# Example: show panel to the right of button, aligned to top
		info_panel.position = button_pos + Vector2(button_size.x + -950, -1100)

	info_panel.visible = true

func update_machine_panel():
	if current_hovered_button and current_hovered_machine != "":
		show_machine_info(current_hovered_machine, current_hovered_button, true)

# Hide panel
func hide_machine_panel():
	info_panel.visible = false
	

##Mouse control for Panel
func _on_collection_btn_mouse_entered(): 
	show_machine_info("Collector", collector_btn)

func _on_shredder_btn_mouse_entered():
	show_machine_info("Shredder", shredder_btn)

func _on_washer_btn_mouse_entered():
	show_machine_info("Washer", washer_btn)

func _on_sorter_btn_mouse_entered():
	show_machine_info("Sorter", sorter_btn)

func _on_extruder_btn_mouse_entered():
	show_machine_info("Extruder", extruder_btn)

func _on_market_btn_mouse_entered():
	show_machine_info("Market", market_btn)


###### Exiting hides the panel

func _on_collection_btn_mouse_exited():
	hide_machine_panel()

func _on_shredder_btn_mouse_exited():
	hide_machine_panel()

func _on_washer_btn_mouse_exited():
	hide_machine_panel()

func _on_sorter_btn_mouse_exited():
	hide_machine_panel()

func _on_extruder_btn_mouse_exited():
	hide_machine_panel()

func _on_market_btn_mouse_exited():
	hide_machine_panel()

