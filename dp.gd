extends State
class_name dragonfist
var bunny : Bunny
var bunny_sprite = Sprite2D
func _ready():
	bunny = $"../../Bunny"
	bunny_sprite = $"../../Bunny/AnimatedSprite2D"
# Called when the node enters the scene tree for the first time.

func Enter():
	print("dp state entered")
	bunny_sprite.play("dragonfist")
	
func Exit():
	print("Exited dp state")
	if bunny.is_flying == true:
		transitioned.emit("flying")
func Update(_delta:float):
	pass
func Physics_Update(_delta:float ):
	pass
