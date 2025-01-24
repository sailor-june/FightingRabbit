extends Node2D

# Adjustable properties
@export var air_item_scene: PackedScene
@export var air_height_range: Vector2 = Vector2(100, -300)  # Min and max height for air items
@export var camera_node_path: NodePath = "../Bunny/AnimatedSprite2D/Camera2D"  # Path to the Camera2D node
@onready var bunny = $"../Bunny"

# Internal variables
var air_items: Array = []
var item_spacing: int = 64  # Horizontal spacing between items
var screen_width: float = 0  # Dynamically calculated
var screen_height: float = 0
var extra_width: float = 0  # Half-screen width for extra buffer
var previous_camera_position_x: float = 0  # Track previous camera position
var num_items = 5

func _ready():
	# Get screen dimensions and extra buffer
	var camera = get_node_or_null(camera_node_path) as Camera2D
	if not camera:
		push_error("Camera2D node not found! Check the 'camera_node_path'.")
		return

	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	extra_width = screen_width / 2

	# Spawn initial air items
	var total_width = screen_width + extra_width * 2
	for i in range(num_items):
		var item = air_item_scene.instantiate()
		item.carrot_body_entered.connect(_on_carrot_body_entered)
		item.position = Vector2(i * item_spacing, randf_range(air_height_range.x, air_height_range.y))
		add_child(item)
		air_items.append(item)

	previous_camera_position_x = get_node_or_null(camera_node_path).global_position.x

func _process(delta: float):
	update_air_items(delta)

func update_air_items(delta: float):
	air_height_range = Vector2(bunny.global_position.y - screen_height / 2, bunny.global_position.y + screen_height / 2)
	var camera = get_node_or_null(camera_node_path) as Camera2D
	if not camera:
		return

	var cam_position_x = camera.global_position.x
	var cam_velocity_x = cam_position_x - previous_camera_position_x  # Camera velocity
	previous_camera_position_x = cam_position_x

	# Adjust extra width based on camera velocity (move items farther ahead if moving quickly)
	var dynamic_extra_width = extra_width + abs(cam_velocity_x) * delta

	# Calculate the left and right boundaries for drawing air items
	var left_boundary = cam_position_x - (screen_width / 2) - dynamic_extra_width
	var right_boundary = cam_position_x + (screen_width / 2) + dynamic_extra_width
	
	if bunny.linear_velocity.x < 3000:
		if air_items.size()< num_items:
			spawn_new_item()  # Remove items that go off-screen and generate new ones based on bunny's position
		for item: Area2D in air_items:
			if item.global_position.x + item_spacing < left_boundary:
				# Queue free the item th.at has moved off-screen to the left
				item.queue_free()
				air_items.erase(item)
				spawn_new_item()

		#elif item.global_position.x > right_boundary:
			## Queue free the item that has moved off-screen to the right
			#item.queue_free()
			#air_items.erase(item)
			#spawn_new_item()

func spawn_new_item() -> void:
	# Create a new air item and position it near the bunny
	var item = air_item_scene.instantiate()
	item.carrot_body_entered.connect(_on_carrot_body_entered)
	
	# Randomly place the item in air height range
	var spawn_x = bunny.global_position.x + (screen_width / 2) + extra_width  # Place slightly off to the right of the bunny
	var spawn_y = randf_range(air_height_range.x, air_height_range.y)

	item.position = Vector2(spawn_x, spawn_y)
	add_child(item)
	air_items.append(item)

func _on_carrot_body_entered(carrot: Carrot) -> void:
	bunny.stamina += 1
	air_items.erase(carrot)  # Use erase instead of remove_at
	carrot.queue_free()
