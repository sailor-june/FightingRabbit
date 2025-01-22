extends State
class_name Flying


@onready var bunny: Bunny = $"../../Bunny"
@onready var bunnysprite: AnimatedSprite2D = $"../../Bunny/AnimatedSprite2D"

func _on_Timer_timeout() -> void:
	
	if bunny.get_contact_count() > 0:
		emit_signal("transitioned", "crashed")
	else:
		print("No contact detected when timer expired. Remaining in current state.")

func Enter():
	bunnysprite.play("flying_test") 
	print("Entered flying state.")

func Exit():
	print("Exited flying state.")
	
func Update(_delta: float):
	print("flying")
