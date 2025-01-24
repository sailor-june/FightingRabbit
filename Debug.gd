extends VBoxContainer

@onready var bunny = $"../../../.."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body. 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Velo.text ="velocity: " + str(bunny.linear_velocity)
	$Pos.text = "position: "+ str(bunny.position)
	$Rot.text = "rotation: "+ str(bunny.rotation)
