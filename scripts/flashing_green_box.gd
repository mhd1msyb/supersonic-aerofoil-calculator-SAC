#Copyright (c) 2019 Mehdi Msayib#
extends Sprite





func _input(event):
	
	
	if event.is_action_pressed("l_click"):
		queue_free()
	
	if event is InputEventScreenTouch:
		if event.pressed==false:
			queue_free()