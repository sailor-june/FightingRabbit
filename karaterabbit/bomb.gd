extends Area2D
@export var impulse_strength: float = 500.0  # Adjust strength as needed

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if body is Bunny:
		
		body.launch(Vector2(impulse_strength,impulse_strength*-1))
		queue_free()  # Remove the bomb after applying the effect
