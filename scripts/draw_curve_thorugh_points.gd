extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
#func _ready():
#	print(get_parent().get_child_count())
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	var coord_array=[]
	var graph=get_parent().get_parent().get_parent()
	
	if get_parent().get_child_count()>2:
	
		for i in range(get_parent().get_child_count()):
			if get_parent().get_child(i)!=self:
				if i<len(global_var.cL_plot_list): # make sure that we don't draw a line through the points going through the bow shock vertical line
					coord_array.append(get_parent().get_child(i).global_transform.origin-graph.rect_global_position)
		var r=global_var.random_graph_point_color.x
		var g=global_var.random_graph_point_color.y
		var b=global_var.random_graph_point_color.z
		draw_polyline(coord_array,Color(r,g,b),2,true)
	#draw_multiline(_draw_bow_shock_DASHED_VERTICAL_line(),Color(0,1,0),1,false)
	#draw_line(Vector2(0,0),get_viewport().size*0.5,Color(randf(),randf(),0))
	
	
func _draw_bow_shock_DASHED_VERTICAL_line():
	
	var yVal=Vector2()
	var point_coord_y_array=[]
	var max_y_point_coord=0
	var line_array=[]

	var graph=get_parent().get_parent().get_parent()
	if get_parent().get_child_count()>2:
		if abs(global_var.bow_shock_angle)<10: # check if a bow shock exists or not
			
			for i in range(get_parent().get_child_count()): #find max point Y coord value
				if get_parent().get_child(i)!=self:
					point_coord_y_array.append(get_parent().get_child(i).global_transform.origin.y-graph.rect_global_position.y)
			
			max_y_point_coord=global_var._max(point_coord_y_array)
			
			
			var yval=global_var._linspace(max_y_point_coord,0,11)
			
			for i in range(11):
				
				line_array.append(Vector2(0,yval[i]))
			
	return line_array
				
