extends Node

var player_coins: int = 200

func player_has_coins(amount: int) -> bool:
	return player_coins >= amount

func deduct_coins(amount: int) -> void:
	player_coins -= amount
	print("Coins left: ", player_coins)

var conveyor_active = false
var plastic_per_click: int = 5   # starting value


##Below for Machine upgrades
var machines = {
	"Collector": {
		"level": 0,
		"base_cost": 100,
		"cost_multiplier": 1.5,
		"base_production": 5,
		"production_multiplier": 1.2
	},
	"Shredder": {
		"level": 0,
		"base_cost": 500,
		"cost_multiplier": 1.5,
		"base_production": 15,
		"production_multiplier": 1.3
	},
	"Washer": {
		"level": 0,
		"base_cost": 1500,
		"cost_multiplier": 1.6,
		"base_production": 40,
		"production_multiplier": 1.25
	}
}
func get_upgrade_cost(machine_name: String) -> int:
	var m = machines[machine_name]
	return int(m.base_cost * pow(m.cost_multiplier, m.level))

func get_production(machine_name: String) -> float:
	var m = machines[machine_name]
	if m.level == 0:
		return 0
	return m.base_production * pow(m.production_multiplier, m.level - 1)
