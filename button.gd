extends Button

@onready var bunny = $"../../../../"
@onready var force = Vector2.ZERO
@export var force_x = 0
@export var force_y = 0

func _ready() -> void:
	print(bunny)
func _on_launch_button_pressed():
	var force = Vector2.ZERO
	force.x = force_x
	force.y = force_y *-1
	
	bunny.launch(force)
	
