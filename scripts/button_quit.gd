#Copyright (c) 2019 Mehdi Msayib#
extends Button



onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")


	

	

func _on_button_quit_button_up():
	get_tree().quit()
