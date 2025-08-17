extends Node2D

var drift_data: Dictionary = {}  # Stores drift info for each sprite
@export var bobbing_amplitude: float = 3.0
@export var bobbing_speed: float = 2.0
@export var confine_area: Rect2 = Rect2(Vector2(1072.49, -234.5), Vector2(642.5, 1115)) 
@export var respawn_time: float = 10.0 

func _ready() -> void:
	randomize()

	for sprite in get_children():
		if sprite is Sprite2D:
			_init_plastic(sprite)

func _process(delta: float) -> void:
	for sprite in drift_data.keys():
		var data: Dictionary = drift_data[sprite]
		data["phase"] += delta * bobbing_speed

		sprite.position += data["drift_speed"] * delta
		sprite.position.y += sin(data["phase"]) * bobbing_amplitude * delta

		if not confine_area.has_point(sprite.position):
			var drift: Vector2 = data["drift_speed"]

			if sprite.position.x < confine_area.position.x or sprite.position.x > confine_area.end.x:
				drift.x = -drift.x
			if sprite.position.y < confine_area.position.y or sprite.position.y > confine_area.end.y:
				drift.y = -drift.y

			data["drift_speed"] = drift
			
			sprite.position = sprite.position.clamp(confine_area.position, confine_area.end)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var click_pos: Vector2 = get_global_mouse_position()

		for sprite in drift_data.keys():
			if sprite is Sprite2D and sprite.texture:
				var rect: Rect2 = sprite.get_rect()
				if rect.has_point(sprite.to_local(click_pos)):
					global_gold.money += 5
					_despawn_plastic(sprite)
					break

func _despawn_plastic(sprite: Sprite2D) -> void:
	drift_data.erase(sprite)
	sprite.visible = false
	await get_tree().create_timer(respawn_time).timeout
	_respawn_plastic(sprite)


func _respawn_plastic(sprite: Sprite2D) -> void:
	sprite.visible = true
	_init_plastic(sprite)


func _init_plastic(sprite: Sprite2D) -> void:
	var random_pos = Vector2(
		randf_range(confine_area.position.x, confine_area.position.x + confine_area.size.x),
		randf_range(confine_area.position.y, confine_area.position.y + confine_area.size.y)
	)
	sprite.position = random_pos

	drift_data[sprite] = {
		"start_position": sprite.position,
		"drift_speed": Vector2(randf_range(-10, 10), randf_range(-5, 5)),
		"phase": randf() * TAU
	}
