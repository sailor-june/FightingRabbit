extends Label

@onready var bunny =  $"../../../.."
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text =  "X: "+ str(bunny.global_position.x) + "   Y: " + str(bunny.global_position.y)
