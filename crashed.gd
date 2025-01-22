extends State
class_name crashed
var bunny : Bunny
var bunny_sprite = Sprite2D
func _ready():
	bunny = $"../../Bunny"
	bunny_sprite = $"../../Bunny/AnimatedSprite2D"
# Called when the node enters the scene tree for the first time.

func Enter():
	print("crash state enter")
	bunny.is_crashed = true
	bunny_sprite.play("crashed")
	
func Exit():
	pass
func Update(_delta:float):
	pass
func Physics_Update(_delta:float ):
	pass
