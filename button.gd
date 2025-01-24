extends Button
class_name reset_button




@onready var bunny = get_tree()
@onready var force = Vector2.ZERO
@export var force_x = 0
@export var force_y = 0

func _ready() -> void:
	text = "reset"

func _on_reset_button_pressed():
	get_tree().reload_current_scene()
