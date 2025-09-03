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


func _ready():
	open_button.pressed.connect(_on_open_button_pressed)
	close_button.pressed.connect(_on_close_button_pressed)
	upgrade1_button.pressed.connect(_on_upgrade_button_pressed)

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

func _on_upgrade_button_pressed():
	GameManager.plastic_per_click += 1
	print(GameManager.plastic_per_click)

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

$UpgradeBG/ScrollContainer/VBoxContainer/Label.text = "Level: " + str(level) + " | Cost: " + str(cost)


