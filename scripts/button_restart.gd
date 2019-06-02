extends Button
#Copyright Mehdi Msayib#
# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _on_button_restart_pressed():
	global_var._refresh_lists()
	get_tree().reload_current_scene()
	pass # replace with function body
