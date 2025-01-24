extends State
class_name fireball
var bunny : Bunny
var bunny_sprite = Sprite2D
@onready var fireball_scene: PackedScene = load("res://fireball_entity.tscn")
var cost = 1
var velocity = Vector2(750,300)
func _ready():
	bunny = $"../../Bunny"
	bunny_sprite = $"../../Bunny/AnimatedSprite2D"
# Called when the node enters the scene tree for the first time.

func Enter():
	print("fireball state entered")
	if bunny.stamina >= cost:
		bunny.stamina-=cost
		var fireball_instance = fireball_scene.instantiate()
		fireball_instance.global_position = bunny.global_position
		fireball_instance.rotation = bunny.rotation
		
		$"../../".add_child(fireball_instance)
		var global_impulse = Vector2(velocity.x + velocity.x * bunny.rotation, velocity.y + velocity.y* bunny.rotation)
		fireball_instance.linear_velocity.x = bunny.linear_velocity.x + global_impulse.x
		if global_impulse.x < 0:
			global_impulse.x *= -1
		print(global_impulse)
		bunny_sprite.play("fireball")
		bunny.launch(global_impulse)
		
		bunny.is_special = true
	else:
		print ("insufficient stamina")
		emit_signal("transitioned","flying")
		pass
func Exit():
	print("Exited fireball state")
	bunny.is_special = false

func Update(_delta:float):
	pass
func Physics_Update(_delta:float ):
	pass
