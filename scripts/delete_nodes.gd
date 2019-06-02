extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=pivot.get_node("Line2D_bottom")
onready var button_edit=get_parent().get_node("button_edit")
	
	

func _input(event):
	
	for i in line2d_bottom.get_child_count():
		if line2d_bottom.get_child(i).pressed and i>0 and line2d_bottom.get_point_count()>4:
			line2d_bottom.remove_point(i)
			line2d_bottom.get_child(i).queue_free()
				
				
	if button_edit.pressed==false:
		queue_free()