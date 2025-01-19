extends Node2D

# Constants
const INPUT_BUFFER_SIZE = 10  # Number of inputs to store
const INPUT_TIMEOUT = 0.6  # Seconds before an input expires

# Input mappings (adjust to your setup)
const INPUT_MAP = {
	"up": "UP",
	"down": "DOWN",
	"left": "LEFT",
	"right": "RIGHT",
	"light_attack": "LIGHT",
	"heavy_attack": "HEAVY",
	"special_attack": "SPECIAL"
}

var special_moves = {
	"Fireball": ["DOWN", "RIGHT", "LIGHT"],
	"Dragon's Fist": ["RIGHT", "DOWN", "RIGHT", "SPECIAL"]
}

# Variables
var input_buffer: Array = []  # Stores recent inputs
var input_times: Array = []   # Stores input timestamps

func _process(delta: float) -> void:
	# Clear expired inputs
	_prune_input_buffer()
	
	# Detect new inputs
	for action in INPUT_MAP.keys():
		if Input.is_action_just_pressed(action):
			_add_input(INPUT_MAP[action])
	
	# Debug: Print the full input buffer
	if input_buffer.size() > 0:
		print("Current Input Buffer:", input_buffer)
	
	# Test special_move detection
	_test_special_moves()

func _prune_input_buffer() -> void:
	if input_buffer.size()>0:
			# Remove inputs older than the timeout
		var current_time = Time.get_ticks_msec() / 1000.0
		while input_times.size() > 0 and current_time - input_times[0] > INPUT_TIMEOUT:
			print("Removed expiredinput:", input_buffer[0])  # Debug: Print expired input
			input_buffer.pop_front()
			input_times.pop_front()
	else:
		return
func _add_input(input: String) -> void:
	# Add new input to the buffer
	input_buffer.append(input)
	input_times.append(Time.get_ticks_msec() / 1000.0)

	# Maintain buffer size
	if input_buffer.size() > INPUT_BUFFER_SIZE:
		print("Removed oldest input due to buffer size limit:", input_buffer[0])  # Debug: Print removed input
		input_buffer.pop_front()
		input_times.pop_front()

# Check for specific special_moves
func detect_special_move(special_move: Array) -> bool:
	# Match the special_move sequence to the end of the input buffer
	if input_buffer.size() < special_move.size():
		return false
	for i in range(special_move.size()):
		if input_buffer[input_buffer.size() - special_move.size() + i] != special_move[i]:
			return false
	return true

# Test special_moves
func _test_special_moves() -> void:
	for move_name in special_moves.keys():
		var move_sequence = special_moves[move_name]
		if detect_special_move(move_sequence):
			print(move_name, " Executed!")
			input_buffer.clear()
			input_times.clear()
