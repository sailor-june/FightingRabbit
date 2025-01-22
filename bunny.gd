extends RigidBody2D
class_name Bunny

signal transitioned(state: String)

@onready var timer: Timer = $Timer  # Ensure a Timer node is present as a child
var force: float = 0.0
var is_flying: bool = false
var is_special: bool = false
var is_crashed: bool = false

	
func on_special_finished():
	emit_signal("transitioned", "flying")
	var is_special = false
	
func launch(force: Vector2):
	apply_central_impulse(Vector2(force.x, force.y*-1))
	is_flying = true
	print("launch init")



func _on_body_entered(body: Node) -> void:
	print("Collision detected with:", body.name)
	if is_flying:
		if not timer.is_stopped():
			timer.stop()  # Stop any active timer before starting a new one
		timer.start(0.25)  # Start a 1-second timer





func _on_timer_timeout() -> void:
	if get_contact_count() > 0:
		emit_signal("transitioned", "crashed")
		rotation = 0
	else:
		print("No contact detected when timer expired. Remaining in current state.")
