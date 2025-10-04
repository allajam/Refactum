extends CanvasLayer
####This Script is just to handle opening the machine menu when clicking on a machine

var selected_machine: String = ""

func set_selected_machine(name: String) -> void:
	selected_machine = name
	# Example: update a Label in the menu
	if has_node("TitleLabel"):
		$TitleLabel.text = name
