extends State
class_name fireball
var bunny : Bunny
var bunny_sprite = Sprite2D
@onready var fireball_scene: PackedScene = load("res://fireball_entity.tscn")
func _ready():
	bunny = $"../../Bunny"
	bunny_sprite = $"../../Bunny/AnimatedSprite2D"
# Called when the node enters the scene tree for the first time.

func Enter():
	print("fireball state entered")
	var fireball_instance = fireball_scene.instantiate()
	fireball_instance.global_position = bunny.global_position
	$"../../".add_child(fireball_instance)
	bunny_sprite.play("fireball")
	
	bunny.is_special = true
func Exit():
	print("Exited fireball state")
	bunny.is_special = false

func Update(_delta:float):
	pass
func Physics_Update(_delta:float ):
	pass
