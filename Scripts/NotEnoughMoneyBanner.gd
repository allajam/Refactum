extends Control

@onready var label = $Label

const START_POS = Vector2(-150, -500)  # off-screen top
const END_POS = Vector2(-70, 500)     # on-screen
const FADE_DURATION = 0.1
const DISPLAY_DURATION = 0.4

func _ready():
	visible = false 

func show_banner(message: String):
	label.text = message
	visible = true

	# Stop any running tweens
	if is_inside_tree() and has_node("Tween"):
		var t = get_node("Tween")
		t.kill()  # stops previous animation

	position = START_POS
	modulate.a = 0.0

	var t = create_tween()
	t.tween_property(self, "position", END_POS, FADE_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	t.tween_property(self, "modulate:a", 1.0, FADE_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	t.tween_interval(DISPLAY_DURATION)
	t.tween_property(self, "position", START_POS, FADE_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	t.tween_property(self, "modulate:a", 0.0, FADE_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	t.connect("finished", Callable(self, "_on_tween_finished"))


func _on_tween_finished():
	visible = false
