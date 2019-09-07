#Copyright (c) 2019 Mehdi Msayib#
extends Button




func _on_button_restart_pressed():
	global_var._refresh_lists()
	get_tree().reload_current_scene()
	pass # replace with function body
