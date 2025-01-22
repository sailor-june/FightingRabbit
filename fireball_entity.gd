extends Sprite2D
class_name fireball_entity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("fireball spawn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -=1
	if $VisibleOnScreenNotifier2D.is_on_screen() == false:
		queue_free()
