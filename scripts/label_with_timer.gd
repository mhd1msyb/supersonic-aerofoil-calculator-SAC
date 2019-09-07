#Copyright (c) 2019 Mehdi Msayib#
extends RichTextLabel


func _on_Timer_timeout():
	queue_free()
	pass # replace with function body

#func _input(event):
#	if event.is_action_pressed("l_click"):
#		queue_free()