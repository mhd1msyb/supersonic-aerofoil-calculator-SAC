#Copyright (c) 2019 Mehdi Msayib#
extends Node2D



func _draw_curve_through_points():
	var list=[]
	
	for i in range(get_child_count()):
		list.append(get_child(i).global_transform.origin)
	var colour=Color(global_var.random_graph_point_color.x,global_var.random_graph_point_color.y,global_var.random_graph_point_color.z)
	#draw_polyline(list,colour,2)
	#print(get_child_count())
	var test=[Vector2(1,0),Vector2(100,200)]
	#draw_multiline(list,Color(1,0,0),2,true)
	
	pass

func _draw():
	_draw_curve_through_points()
	


func _input(event):
	
	update()
