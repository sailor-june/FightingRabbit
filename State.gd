extends Node
class_name State
signal Transitioned



func Enter():

	$AnimatedSprite2D.play("idle")
	
	
func Exit():
	Transitioned.emit()
func Update(_delta:float):
	pass
func Physics_Update(_delta:float ):
	pass
