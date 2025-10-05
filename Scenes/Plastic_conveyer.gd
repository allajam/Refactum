extends Node2D

func _ready():
	for sprite in get_children():
		if sprite is AnimatedSprite2D:
			sprite.play()  # Plays the default animation automatically
