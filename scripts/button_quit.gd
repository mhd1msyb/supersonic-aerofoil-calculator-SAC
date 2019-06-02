extends Button
#Copyright Mehdi Msayib#
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")


	

	

func _on_button_quit_button_up():
	get_tree().quit()
