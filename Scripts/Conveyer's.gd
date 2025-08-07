# ConveyorBelt.gd
extends Node2D

@onready var sprite = $"Conveyer Belt"

func _process(_delta):
	if GameManager.conveyor_active:
		if not sprite.is_playing():
			sprite.play()
	else:
		if sprite.is_playing():
			sprite.stop()
