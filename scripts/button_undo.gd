extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot").get_node("Line2D_bottom")

func _on_button_undo_pressed():
	
	if line2d_bottom.get_point_count()>1:
		line2d_bottom.remove_point(line2d_bottom.get_point_count()-1) #remove line point
		line2d_bottom.get_child(line2d_bottom.get_point_count()).queue_free() #remove collison node
		#print(pivot.get_child_count())
	#print(line2d_bottom.get_point_count())
	


#func _on_button_undo_mouse_entered():# deprecated
#	global_var.undo_hover=true
#
#
#func _on_button_undo_mouse_exited():#deprecated
#	global_var.undo_hover=false
