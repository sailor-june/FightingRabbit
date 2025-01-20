extends RigidBody2D
class_name Bunny

signal transitioned(state: String)

@onready var timer: Timer = $Timer  # Ensure a Timer node is present as a child
var force: float = 0.0
var is_flying: bool = false
var is_special: bool = false

func on_dragonfist():
	print("dp detected")
	var is_special = true
	emit_signal("transitioned","dragonfist")
	$AnimatedSprite2D.play("dragonfist")
	
func on_special_finished():
	emit_signal("transitioned", "flying")
	var is_special = false
	
func launch(force: Vector2):
	apply_central_impulse(Vector2(force.x, force.y*-1))
	is_flying = true
	print("launch init")



func _on_body_entered(body: Node) -> void:
	print("Collision detected with:", body.name)
	if not timer.is_stopped():
		timer.stop()  # Stop any active timer before starting a new one
	timer.start(1.0)  # Start a 2-second timer

func _on_Timer_timeout() -> void:
	
	if get_contact_count() > 0:
		emit_signal("transitioned", "idle")
	else:
		print("No contact detected when timer expired. Remaining in current state.")
