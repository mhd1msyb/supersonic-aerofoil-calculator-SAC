#Copyright (c) 2019 Mehdi Msayib#
extends HSlider


onready var pivot=get_parent().get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_parent().get_node("pivot/Line2D_bottom")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().hide()
	pass # Replace with function body.




func _on_chord_slider_value_changed(value):
	for i in len(global_var.list_GlobalPointCoords):
		var radius=global_var.list_GlobalPointCoords[i].x-pivot.global_transform.origin.x
		var xcoord=global_var.list_GlobalPointCoords[i].x+(value*radius)*0.1
		var coord=Vector2(xcoord,global_var.list_GlobalPointCoords[i].y)
		line2d_bottom.set_point_position(i,line2d_bottom.to_local(coord)) # update line
		
#		if i==0:
#			pivot.get_child(i+1).rect_global_position=coord
		if i<len(global_var.list_GlobalPointCoords)-1:
			line2d_bottom.get_child(i).rect_global_position=coord-line2d_bottom.get_child(i).rect_size*0.5
		
	pass # Replace with function body.
