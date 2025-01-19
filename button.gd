extends Button

@onready var bunny =  $"../../../.."
@onready var force_input_x = $"../ForceInputX" 
@onready var force_input_y = $"../ForceInputY"  
func _ready() -> void:
	print(bunny)
func _on_launch_button_pressed():
	var force = Vector2.ZERO
	force.x = force_input_x.value
	force.y = force_input_y.value * -1
	
	bunny.launch(force)
