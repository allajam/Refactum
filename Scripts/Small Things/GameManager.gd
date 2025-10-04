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
# Machines dictionary: each machine has a level
var machines = {
	"Collector": {"level": 0, "base_gold": 1},
	"Shredder":  {"level": 0, "base_gold": 2},
	"Washer":    {"level": 0, "base_gold": 3},
	"Sorter":    {"level": 0, "base_gold": 4},
	"Extruder":  {"level": 0, "base_gold": 5},
	"Market":    {"level": 0, "base_gold": 6},
}

# Base costs for machines (at level 0)
var base_costs = {
	"Collector": 100,
	"Shredder":  200,
	"Washer":    300,
	"Sorter":    400,
	"Extruder":  500,
	"Market":    600,
}

# Multipliers for machine upgrades
var multipliers = {
	"Collector": 1.2,
	"Shredder":  1.3,
	"Washer":    1.35,
	"Sorter":    1.4,
	"Extruder":  1.45,
	"Market":    1.5,
}



