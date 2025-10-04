# MoneyDisplay.gd
extends CanvasLayer

@onready var label = $Gold_Amount

func _process(_delta):
	label.text = str(int(global_gold.money))

