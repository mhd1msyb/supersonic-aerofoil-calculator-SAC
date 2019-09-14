#Copyright (c) 2019 Mehdi Msayib#
extends Button



onready var help_scene=preload("res://scenes/help_scene.tscn")




func _on_button_help_pressed():
	global_var._refresh_lists()
	get_tree().change_scene_to(help_scene)
	pass # Replace with function body.
