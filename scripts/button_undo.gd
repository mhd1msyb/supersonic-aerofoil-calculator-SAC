#Copyright (c) 2019 Mehdi Msayib#
extends Button



onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot").get_node("Line2D_bottom")

func _ready():
	hide()



func _on_button_undo_pressed():
	
	if line2d_bottom.get_point_count()>1:
		line2d_bottom.remove_point(line2d_bottom.get_point_count()-1) #remove line point
		line2d_bottom.get_child(line2d_bottom.get_point_count()).queue_free() #remove collison node
		
