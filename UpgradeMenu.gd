extends Control

@onready var upgrade_menu = $UpgradeBG
@onready var open_button = $Upgrades
@onready var close_button = $UpgradeBG/Exit_Button
@onready var upgrade1_button = $UpgradeBG/ScrollContainer/VBoxContainer/PlasticPerClick
@onready var upgrade2_button = $UpgradeBG/ScrollContainer/VBoxContainer/PlasticPerClickMult
@onready var upgrade3_button = $UpgradeBG/ScrollContainer/VBoxContainer/IncomePerRecycle
@onready var upgrade4_button = $UpgradeBG/ScrollContainer/VBoxContainer/MachineWorkSpeed
@onready var upgrade5_button = $UpgradeBG/ScrollContainer/VBoxContainer/GoldenPlasChance
@onready var upgrade6_button = $UpgradeBG/ScrollContainer/VBoxContainer/GoldenPlasAmount
@onready var info_panel = $UpgradeBG/UpgradeInfoPanel
@onready var lbl_level = $UpgradeBG/UpgradeInfoPanel/Label_Level
@onready var lbl_effect = $UpgradeBG/UpgradeInfoPanel/Label_Effect


func _ready():
	open_button.pressed.connect(_on_open_button_pressed)
	close_button.pressed.connect(_on_close_button_pressed)
	upgrade1_button.pressed.connect(_on_upgrade_button_pressed)
	
	

	update_upgrade_cost_labels()
	
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

#UPGRADE 1 & 2
func get_plastic_gain_per_click() -> int:
	var base_level = upgrades["plastic_per_click"]["level"]
	var base_gain = base_level  # each level = +1
	
	var mult_level = upgrades["plastic_per_click_mult"]["level"]
	var mult_gain = pow(2, mult_level)  # each level doubles (2^n)
	
	return base_gain * mult_gain

func _on_upgrade_button_pressed():
	var gain = get_plastic_gain_per_click()
	GameManager.plastic_per_click += gain
	print("Clicked! +%d plastic (total per click: %d)" % [gain, GameManager.plastic_per_click])


var upgrades = {
	"plastic_per_click": {
		"level": 0,
		"base_cost": 20,
		"multiplier": 1.2
	},	
	"plastic_per_click_mult": {
		"level": 0,
		"base_cost": 100,
		"multiplier": 1.3
	},
	"income_per_plastic": {
		"level": 0,
		"base_cost": 50,
		"multiplier": 1.25
	},
	"machine_speed": {
		"level": 0,
		"base_cost": 150,
		"multiplier": 1.4
	},
	"golden_plastic_chance": {
		"level": 0,
		"base_cost": 500,
		"multiplier": 1.5
	},
	"golden_plastic_amount": {
		"level": 0,
		"base_cost": 1000,
		"multiplier": 1.6
	}
}

func get_upgrade_cost(upgrade_name: String) -> int:
	var data = upgrades[upgrade_name]
	return int(data["base_cost"] * pow(data["multiplier"], data["level"]))

func buy_upgrade(upgrade_name: String):
	var cost = get_upgrade_cost(upgrade_name)
	if global_gold.money >= cost:
		global_gold.money -= cost
		upgrades[upgrade_name]["level"] += 1
		print("Bought", upgrade_name, "New level:", upgrades[upgrade_name]["level"])
		update_upgrade_cost_labels()
	else:
		print("Not enough money! Cost:", cost)


func _on_plastic_per_click_pressed():
	buy_upgrade("plastic_per_click")

func _on_plastic_per_click_mult_pressed():
	buy_upgrade("plastic_per_click_mult")

func _on_income_per_recycle_pressed():
	buy_upgrade("income_per_plastic")

func _on_machine_work_speed_pressed():
	buy_upgrade("machine_speed")

func _on_golden_plas_chance_pressed():
	buy_upgrade("golden_plastic_chance")

func _on_golden_plas_amount_pressed():
	buy_upgrade("golden_plastic_amount")



func update_upgrade_cost_labels():
	# Upgrade 1
	var cost1 = get_upgrade_cost("plastic_per_click")
	upgrade1_button.get_node("Label").text = " %d" % cost1

	# Upgrade 2
	var cost2 = get_upgrade_cost("plastic_per_click_mult")
	upgrade2_button.get_node("Label2").text = " %d" % cost2

	# Upgrade 3
	var cost3 = get_upgrade_cost("income_per_plastic")
	upgrade3_button.get_node("Label3").text = " %d" % cost3

	# Upgrade 4
	var cost4 = get_upgrade_cost("machine_speed")
	upgrade4_button.get_node("Label4").text = " %d" % cost4

	# Upgrade 5
	var cost5 = get_upgrade_cost("golden_plastic_chance")
	upgrade5_button.get_node("Label5").text = " %d" % cost5

	# Upgrade 6
	var cost6 = get_upgrade_cost("golden_plastic_amount")
	upgrade6_button.get_node("Label6").text = " %d" % cost6

###INFO PANEL Code:
func show_upgrade_info(upgrade_name: String):
	var upgrade = upgrades[upgrade_name]
	var level = upgrade["level"]

	var current_effect: float
	var next_effect: float

	if upgrade_name == "plastic_per_click":
		# Base gain without multiplier
		current_effect = 5 + level
		next_effect = 5 + level + 1
	elif upgrade_name == "plastic_per_click_mult":
		# Show multiplier itself, not total gain
		current_effect = pow(2, level)       # current multiplier
		next_effect = pow(2, level + 1)      # next multiplier
	else:
		# Other upgrades
		current_effect = level * upgrade.get("effect_per_level", 1)
		next_effect = (level + 1) * upgrade.get("effect_per_level", 1)

	lbl_level.text = "Level %d  -->  Level %d" % [level, level + 1]
	lbl_effect.text = "%.1fx  -->  %.1fx" % [current_effect, next_effect]

	info_panel.visible = true






##Hide/Show Info Panel
func _on_plastic_per_click_mouse_exited(): 
	info_panel.visible = false
func _on_plastic_per_click_mult_mouse_exited():
	info_panel.visible = false
func _on_income_per_recycle_mouse_exited():
	info_panel.visible = false
func _on_machine_work_speed_mouse_exited():
	info_panel.visible = false
func _on_golden_plas_chance_mouse_exited():
	info_panel.visible = false
func _on_golden_plas_amount_mouse_exited():
	info_panel.visible = false

func _on_plastic_per_click_mouse_entered():
	info_panel.visible = true
	show_upgrade_info("plastic_per_click")
func _on_plastic_per_click_mult_mouse_entered():
	info_panel.visible = true
	show_upgrade_info("plastic_per_click_mult")
func _on_income_per_recycle_mouse_entered():
	info_panel.visible = true
	show_upgrade_info("income_per_plastic")
func _on_machine_work_speed_mouse_entered():
	info_panel.visible = true
	show_upgrade_info("machine_speed")
func _on_golden_plas_chance_mouse_entered():
	info_panel.visible = true
	show_upgrade_info("golden_plastic_chance")
func _on_golden_plas_amount_mouse_entered():
	info_panel.visible = true
	show_upgrade_info("golden_plastic_amount")
