extends Node2D

# Normal plastic drift settings
var drift_data: Dictionary = {}
@export var bobbing_amplitude: float = 3.0
@export var bobbing_speed: float = 2.0
@export var confine_area: Rect2 = Rect2(Vector2(1072.49, -234.5), Vector2(642.5, 1115))
@export var respawn_time: float = 10.0

# Golden plastic timer
var golden_timer: Timer

func _ready() -> void:
	randomize()

	# Initialize all normal plastics
	for sprite in get_children():
		if sprite is Sprite2D and not sprite.name.begins_with("Golden"):
			_init_plastic(sprite)

	# Start golden plastic spawning timer
	start_golden_timer()


func _process(delta: float) -> void:
	# Normal plastic
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

	# Golden plastic
	for sprite in get_children():
		if sprite is Sprite2D and sprite.visible and sprite.name.begins_with("Golden"):
			if not drift_data.has(sprite):
				drift_data[sprite] = {
					"phase": randf() * TAU,
					"drift_speed": Vector2(randf_range(-10,10), randf_range(-5,5))
				}
			var data = drift_data[sprite]
			data["phase"] += delta * bobbing_speed
			sprite.position += data["drift_speed"] * delta
			sprite.position.y += sin(data["phase"]) * bobbing_amplitude * delta



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var click_pos: Vector2 = get_global_mouse_position()

		for sprite in get_children():
			if sprite is Sprite2D and sprite.visible:
				var rect: Rect2 = sprite.get_rect()
				if rect.has_point(sprite.to_local(click_pos)):
					if sprite.name.begins_with("Golden"):
						# Golden plastic reward uses your upgrade multiplier
						global_gold.money += GameManager.plastic_per_click * GameManager.golden_multiplier
						
						sprite.visible = false
						await get_tree().create_timer(GameManager.golden_spawn_interval).timeout
						_spawn_golden_plastic()
					else:
						global_gold.money += GameManager.plastic_per_click
						_despawn_plastic(sprite)
					break





func _despawn_plastic(sprite: Sprite2D) -> void:
	drift_data.erase(sprite)
	sprite.visible = false
	await get_tree().create_timer(respawn_time).timeout
	_init_plastic(sprite)


func _init_plastic(sprite: Sprite2D) -> void:
	var random_pos = Vector2(
		randf_range(confine_area.position.x, confine_area.end.x),
		randf_range(confine_area.position.y, confine_area.end.y)
	)
	sprite.position = random_pos

	drift_data[sprite] = {
		"start_position": sprite.position,
		"drift_speed": Vector2(randf_range(-10, 10), randf_range(-5, 5)),
		"phase": randf() * TAU
	}
	sprite.visible = true


# -----------------------------
# Golden Plastic Handling
# -----------------------------
func start_golden_timer():
	golden_timer = Timer.new()
	golden_timer.wait_time = GameManager.golden_spawn_interval
	golden_timer.one_shot = false
	golden_timer.autostart = true
	golden_timer.connect("timeout", Callable(self, "_spawn_golden_plastic"))
	add_child(golden_timer)
	golden_timer.start()


func _spawn_golden_plastic():
	# Spawn the first invisible golden plastic you find
	for sprite in get_children():
		if sprite.name.begins_with("Golden") and not sprite.visible:
			sprite.visible = true
			sprite.position = Vector2(
				randf_range(confine_area.position.x, confine_area.end.x),
				randf_range(confine_area.position.y, confine_area.end.y)
			)
			break



func update_golden_timer():
	if golden_timer:
		golden_timer.wait_time = max(2, 20 - GameManager.golden_chance_level * 2)
		golden_timer.start()
