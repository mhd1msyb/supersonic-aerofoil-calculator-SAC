extends HSlider

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pivot=get_parent().get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_parent().get_node("pivot/Line2D_bottom")
#onready var preload_collison_node=preload("res://scenes/collision_node.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().hide()
	pass # Replace with function body.

#func _add_collision_node(coord):
#	#if global_var.finish_button_hover==false:
#	var preload_collision_node_instance=preload_collison_node.instance()
#	line2d_bottom.add_child(preload_collision_node_instance)
#	preload_collision_node_instance.rect_global_position=coord-preload_collision_node_instance.rect_size*0.5

func _on_thickness_slider_value_changed(value):

#	for i in line2d_bottom.get_child_count():
#		line2d_bottom.get_child(i).queue_free()


	for i in len(global_var.list_GlobalPointCoords):
		if i!=0 and i!=global_var.index_bottom_top_plate: # make sure start + end edges are not affected
			var radius=global_var.list_GlobalPointCoords[i].y-pivot.global_transform.origin.y
			var ycoord=global_var.list_GlobalPointCoords[i].y+(value*radius)
			var coord=Vector2(global_var.list_GlobalPointCoords[i].x,ycoord)
			line2d_bottom.set_point_position(i,line2d_bottom.to_local(coord)) # update line
	#		if i==0:
	#			pivot.get_child(i+1).rect_global_position=coord
	
			if i<len(global_var.list_GlobalPointCoords)-1:
				line2d_bottom.get_child(i).rect_global_position=coord-line2d_bottom.get_child(i).rect_size*0.5
	
	
#			if i<len(global_var.list_GlobalPointCoords)-1:
#				_add_collision_node(coord)
			
		#print(pivot.to_global(line2d_bottom.get_point_position(i)).y-pivot.global_transform.origin.y)