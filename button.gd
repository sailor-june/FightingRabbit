extends Button

@onready var bunny = $"../../../../../"
@onready var force = Vector2.ZERO
@export var force_x = 0
@export var force_y = 0

func _ready() -> void:
	print(bunny)
func _on_launch_button_pressed():
	get_tree().reload_current_scene()
