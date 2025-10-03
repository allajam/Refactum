extends Area2D

@export var cost: int = 100
@export var machine_scene: PackedScene

@onready var label: Label = $Label

func _ready():
	# Update label text to show name and cost if you want:
	if machine_scene:
		label.text = "%s - %d Coins" % [machine_scene.resource_path.get_file().get_basename(), cost]
	else:
		label.text = "No machine assigned - %d Coins" % cost
	connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if GameManager.player_has_coins(cost):
			if machine_scene == null:
				print("Error: machine_scene not assigned!")
				return
			var machine = machine_scene.instantiate()
			machine.global_position = global_position
			get_parent().add_child(machine)
			GameManager.deduct_coins(cost)
			queue_free()
		else:
			print("Not enough coins")
