#Copyright (c) 2019 Mehdi Msayib#
extends Node2D


onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=pivot.get_node("Line2D_bottom")
onready var button_edit=get_parent().get_node("button_edit")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	var index=0
	
	
	
	for i in (line2d_bottom.get_child_count()):
		var node=line2d_bottom.get_child(i)
		if node.pressed:
			var mouse_pos=get_viewport().get_mouse_position()
			index=node.get_position_in_parent()


			if index==0: # update line (ensure that if first node selected then both final and initial points on line move in unison)
				line2d_bottom.set_point_position(index,line2d_bottom.to_local(mouse_pos)) 
				line2d_bottom.set_point_position(line2d_bottom.get_point_count()-1,line2d_bottom.get_point_position(0)) #move node
				
			else:# update line
				line2d_bottom.set_point_position(index,line2d_bottom.to_local(mouse_pos)) 
			
			
			node.rect_global_position=line2d_bottom.to_global(line2d_bottom.get_point_position(index))-node.rect_size*0.5 #move node
			break
			
			
	if button_edit.pressed==false: #delete script when edit button is pressed again
		queue_free()
