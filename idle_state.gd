extends  State
class_name Idle


@onready var bunny = $"../../Bunny/AnimatedSprite2D"

func Enter():
	
	print("entering idle")
	bunny.play("idle_test")
	
func Exit():
	print("exiting idle")
	
func Update(_delta:float):
	pass
func Physics_Update(_delta:float ):
	pass
