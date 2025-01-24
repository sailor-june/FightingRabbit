extends Area2D
class_name Carrot
signal carrot_body_entered
# Called when the node enters the scene tree for the first time.


func _on_body_entered(body: Node2D) -> void:
	if body is Bunny:
		emit_signal("carrot_body_entered", self)
		
