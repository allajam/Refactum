extends CanvasLayer

# Pages of tutorial text
var pages = [
	
	"  This game is a tycoon factory game where your aim is to
	   get rid of the pollution and rubbish in the ocean and beach   
	   ",
	"  You can move around by using WASD and zooming in and out,
	   You left click to interact and to reach the pause menu you
	   can press Escape 
	",
	"  To Start you must collect plastic from the Ocean to 
	   your right, you will earn Money from this.                                  
	",
	"  With this money you can spend it on different things
	   such as new Machines and Upgrades                                       
	",
	"  The process of recycling plastic as shown here is simplified
	   However it is realistic, if you want to find out more about this
	   have a look in the help settings                                
	", 
	"  Good luck!                                                     
	",
]

var current_page = 0

@onready var label = $Control/PanelContainer/VBoxContainer/TutorialText
@onready var button = $Control/PanelContainer/VBoxContainer/ContinueButton

func _ready():
	# Show first page
	label.text = pages[current_page]
	button.pressed.connect(_on_continue_pressed)

func _on_continue_pressed():
	current_page += 1
	if current_page < pages.size():
		label.text = pages[current_page]
	else:
		hide()  # Finished tutorial



