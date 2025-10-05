extends Node

var player_coins: int = 200

func player_has_coins(amount: int) -> bool:
	return player_coins >= amount

func deduct_coins(amount: int) -> void:
	player_coins -= amount
	print("Coins left: ", player_coins)

var conveyor_active = false
var plastic_per_click: int = 5   # starting value

var gps_multiplier: float = 1.0



# Golden plastic upgrades
var golden_spawn_interval: float = 40.0
var golden_spawn_reduction_per_level: float = 3.0
var golden_spawn_level: int = 0

var golden_multiplier: float = 10.0
var golden_multiplier_per_level: float = 10.0
var golden_amount_level: int = 0


