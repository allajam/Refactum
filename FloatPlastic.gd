extends Node2D

var drift_data = {}  # Stores drift info for each sprite
@export var bobbing_amplitude := 3.0
@export var bobbing_speed := 2.0

func _ready():
	randomize()

	for sprite in get_children():
		drift_data[sprite] = {
			"start_position": sprite.position,
			"drift_speed": Vector2(randf_range(-10, 10), randf_range(-5, 5)),
			"phase": randf() * TAU
		}

func _process(delta):
	for sprite in drift_data.keys():
		var data = drift_data[sprite]
		data.phase += delta * bobbing_speed

		# Apply drift and bobbing
		sprite.position += data.drift_speed * delta
		sprite.position.y += sin(data.phase) * bobbing_amplitude * delta

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var click_pos = get_global_mouse_position()

		for sprite in drift_data.keys():
			if sprite is Sprite2D and sprite.texture:
				var rect = sprite.get_rect()  
				if rect.has_point(sprite.to_local(click_pos)):
					global_gold.money += 5
					drift_data.erase(sprite)
					sprite.queue_free()
					break

