extends State
class_name Flying


@onready var bunny: Bunny = $"../../Bunny"
@onready var bunnysprite: AnimatedSprite2D = $"../../Bunny/AnimatedSprite2D"
func Enter():
	bunnysprite.play("flying_test") 
	print("Entered flying state.")

func Exit():
	print("Exited flying state.")

func Update(_delta: float):
	print("flying")
	if bunny.get_contact_count() > 0:
		print("contact")
		for i in range(bunny.get_contact_count()):
			var collider = bunny.get_contact_collider_object(i)
			if collider and collider.is_in_group("floor"):  # Assuming your floor is in the "floor" group
				emit_signal("transitioned", "idle")
				break
