extends Node2D
class_name  input_monitor
const INPUT_TIMEOUT = 0.6  # Seconds before an input expires
#signal dragonfist
# Input mappings (adjust to your setup)
const INPUT_MAP = {
	"up": "UP",
	"down": "DOWN",
	"left": "LEFT",
	"right": "RIGHT",
	"light_attack": "LIGHT",
	"heavy_attack": "HEAVY",
	"special_attack": "SPECIAL"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for action in INPUT_MAP.keys():
		if Input.is_action_just_pressed(action):
			
			for child in get_children():
				if child.name.to_lower() == action.to_lower():
					child.play("pressed")
		elif Input.is_action_just_released(action):
			for child in get_children():
				if child.name.to_lower() == action.to_lower():
					child.play("default")
