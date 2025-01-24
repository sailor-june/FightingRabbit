extends Node
class_name StateMachine

var current_state : State
var states = {}
@export var initial_state: State
func _ready() -> void:
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	if $"../Bunny" != null:
		$"../Bunny".transitioned.connect(on_bunny_transition)
		print("bun online")
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func on_bunny_transition(new_state_name: String) -> void:
	var new_state = states.get(new_state_name.to_lower())
	if new_state and new_state != current_state:
		current_state.Exit()
		new_state.Enter()
		current_state = new_state
		
		
			
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state: 	
		current_state.Exit()
		
	new_state.Enter()
	current_state = new_state
	
	
func _process(delta: float) -> void:
	current_state.Update(delta)

func _physics_process(delta: float) -> void:
	current_state.Physics_Update(delta)
