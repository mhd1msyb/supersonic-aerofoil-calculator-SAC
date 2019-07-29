#Copyright (c) 2019 Mehdi Msayib#
extends Button



onready var about_scene=preload("res://scenes/about_scene.tscn")




func _on_button_about_pressed():
	global_var._refresh_lists()
	get_tree().change_scene_to(about_scene)
	pass # Replace with function body.
