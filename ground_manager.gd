extends Node2D

# Adjustable properties
@export var ground_segment_scene: PackedScene = load("res://ground_segment.tscn")
@export var ground_height: float = 64 # Y-coordinate for the ground level
@export var camera_node_path: NodePath = "../Bunny/AnimatedSprite2D/Camera2D" # Path to the Camera2D node

# Internal variables
var ground_segments: Array = []
var ground_width: int = 32  # Each ground segment is 32 pixels wide
var screen_width: float = 0  # Dynamically calculated
var extra_width: float = 0  # Half-screen width for extra buffer

func _ready():
	# Get screen width from the viewport
	var camera = get_node_or_null(camera_node_path) as Camera2D
	if not camera:
		push_error("Camera2D node not found! Check the 'camera_node_path'.")
		return
	
	screen_width = get_viewport_rect().size.x
	extra_width = screen_width / 2

	# Spawn initial ground segments
	var total_width = screen_width + extra_width * 2
	var num_segments = int(ceil(total_width / ground_width))
	for i in range(num_segments):
		var segment = ground_segment_scene.instantiate()
		segment.position = Vector2(i * ground_width, ground_height)
		add_child(segment)
		ground_segments.append(segment)

func _process(delta: float):
	update_ground()

func update_ground():
	# Get the camera's current position
	var camera = get_node_or_null(camera_node_path) as Camera2D
	if not camera:
		return

	var cam_position_x = camera.global_position.x

	# Calculate the left and right boundaries for drawing ground
	var left_boundary = cam_position_x - (screen_width / 2) - extra_width
	var right_boundary = cam_position_x + (screen_width / 2) + extra_width

	# Check if any ground segment needs to be recycled
	for segment in ground_segments:
		if segment.global_position.x + ground_width < left_boundary:
			# Move segment to the right side
			var max_x = get_max_ground_x()
			segment.position.x = max_x + ground_width
		elif segment.global_position.x > right_boundary:
			# Move segment to the left side
			var min_x = get_min_ground_x()
			segment.position.x = min_x - ground_width

func get_max_ground_x() -> float:
	var max_x = float(-INF)
	for segment in ground_segments:
		max_x = max(max_x, segment.global_position.x)
	return max_x

func get_min_ground_x() -> float:
	var min_x = float(INF)
	for segment in ground_segments:
		min_x = min(min_x, segment.global_position.x)
	return min_x
