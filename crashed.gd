extends State
class_name crashed
var bunny : Bunny
var bunny_sprite = Sprite2D
var crash_button: Button

func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
func _ready():
	bunny = $"../../Bunny"
	bunny_sprite = $"../../Bunny/AnimatedSprite2D"
	
		
# Called when the node enters the scene tree for the first time.

func Enter():
	print("crash state enter")
	bunny.is_crashed = true
	bunny_sprite.play("crashed")
	var crash_label = Label.new()
	crash_label.text = "game over!"
	bunny.add_child(crash_label)
	
	var distance_flown_label = Label.new()
	distance_flown_label.text = "Distance Traveled: " +str(round_place(bunny.position.x/1000, 2)) + " meters"
	
	
	var new_crash_button = reset_button.new()
	
	new_crash_button.text = "reset"
	new_crash_button.pressed.connect(new_crash_button._on_reset_button_pressed)
	crash_button = new_crash_button
	#crash_button.z_index = 1
	crash_label.add_child(new_crash_button)	
	crash_label.add_child( distance_flown_label)
	new_crash_button.position += Vector2(0,50)
	crash_label.position -=Vector2(0,150)
	distance_flown_label.position +=Vector2(0,100)
func Exit():
	pass
func Update(_delta:float):
	pass
	#if crash_button:
		#crash_button.rotation = lerpf(crash_button.rotation, 0, _delta* 0.1)
	#print("..")
	
func Physics_Update(_delta:float ):
	pass
