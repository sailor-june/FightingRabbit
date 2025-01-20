extends Node2D

@export var ground_scene: PackedScene = load("res://ground_segment.tscn" )
@export var segment_length: float = 32
@onready var ground_y: float = 0# Y position of the ground

var active_segments = []  # Store ground segment references
var next_spawn_x: float = 0  # Track where to spawn the next segment

func _ready():
	ground_y=(get_viewport_rect().size.y)
	var width = (get_viewport_rect().size.x)
	var segment_number = width/segment_length
	for i in range(segment_number):  # Start with 3 segments (adjust as needed)
		spawn_ground_segment(next_spawn_x)
		next_spawn_x += segment_length

func _process(delta):
	# Get the camera position and viewport width
	var camera_x = 640
	var viewport_width = get_viewport_rect().size.x

	# Calculate the viewport bounds
	var left_bound = camera_x - viewport_width 
	var right_bound = camera_x + viewport_width 

	# Spawn new segments if the right edge is near
	while next_spawn_x < right_bound + segment_length:
		spawn_ground_segment(next_spawn_x)
		next_spawn_x += segment_length

	# Cleanup segments that are completely outside the viewport
	var segments_to_remove = []
	for segment in active_segments:
		var segment_x = segment.global_position.x
		if segment_x + segment_length < left_bound:  # Segment is completely offscreen to the left
			segments_to_remove.append(segment)

	for segment in segments_to_remove:
		active_segments.erase(segment)
		segment.queue_free()

func spawn_ground_segment(position_x: float):
	# Instance and position a new ground segment
	var segment = ground_scene.instantiate()
	add_child(segment)
	segment.position = Vector2(position_x, ground_y)
	active_segments.append(segment)
	segment.add_to_group("floor")
