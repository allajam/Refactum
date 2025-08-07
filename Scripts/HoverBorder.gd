extends Area2D

@onready var hover_border = $HoverBorder

func _ready():
	hover_border.visible = false
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	hover_border.visible = true

func _on_mouse_exited():
	hover_border.visible = false


