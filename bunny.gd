extends RigidBody2D
class_name Bunny	
var force: float = 0.0

func launch(force:Vector2):
	# 45 degrees in radians = PI / 4
	var angle: float = PI / 4
	
	apply_central_impulse(Vector2(force))
	print("launch init")
