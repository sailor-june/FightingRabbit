extends RigidBody2D
class_name Bunny	
var force: float = 0.0

func _ready() -> void:
	$AnimatedSprite2D.play("idle_test")
func launch(force:Vector2):
	$AnimatedSprite2D.play("flying_test")
	# 45 degrees in radians = PI / 4
	var angle: float = PI / 4
	
	apply_central_impulse(Vector2(force))
	print("launch init")
