extends  State
class_name Idle
@onready var bunny : Bunny
@onready var bunnysprite: AnimatedSprite2D
func _ready():
	bunny = $"../../Bunny"
	bunnysprite = $"../../Bunny/AnimatedSprite2D"

func Enter():
	
	print("entering idle")
	
	
func Exit():
	print("exiting idle")
	
func Update(_delta:float):
	pass
func Physics_Update(_delta:float ):
	pass
