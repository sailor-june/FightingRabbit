extends State
class_name dragonfist
var bunny : Bunny
var bunny_sprite = Sprite2D
var cost = 2
var velocity = Vector2( 200, 1000)
func _ready():
	bunny = $"../../Bunny"
	bunny_sprite = $"../../Bunny/AnimatedSprite2D"
# Called when the node enters the scene tree for the first time.

func Enter():
	if bunny.stamina >= cost:
		print("dp state entered") 
		bunny_sprite.play("dragonfist")
		bunny.stamina -= cost
		bunny.rotation = 0
		bunny.angular_velocity = 0
		bunny.launch(velocity)
		
		bunny.is_special = true
	else:
		print('insufficient stamina for dp')
		emit_signal("transitioned", "flying")
func Exit():
	print("Exited dp state")
	bunny.is_special = false

func Update(_delta:float):
	pass
func Physics_Update(_delta:float ):
	pass
