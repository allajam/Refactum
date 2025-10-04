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






