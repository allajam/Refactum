extends Camera2D

@export var max_speed: float = 350.0
@export var acceleration: float = 1500.0
@export var friction: float = 800.0
@export var zoom_speed: float = 0.1
@export var min_zoom: float = 0.5
@export var max_zoom: float = 3.0

var velocity: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	var input_vector := Vector2.ZERO

	if Input.is_action_pressed("Camera Up"):
		input_vector.y -= 1
	if Input.is_action_pressed("Camera down"):
		input_vector.y += 1
	if Input.is_action_pressed("Camera left"):
		input_vector.x -= 1
	if Input.is_action_pressed("Camera right"):
		input_vector.x += 1

	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	position += velocity * delta
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_zoom_camera(-zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_zoom_camera(zoom_speed)

func _zoom_camera(amount: float) -> void:
	var new_zoom = zoom + Vector2(amount, amount)
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	zoom = new_zoom
	

