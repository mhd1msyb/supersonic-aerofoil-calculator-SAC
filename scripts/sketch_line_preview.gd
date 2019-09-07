#Copyright (c) 2019 Mehdi Msayib#
extends Node2D

"""
this script displays a virtual line which shows what the final line would look 
like (if the user clicked at that location)


"""

var thickness=3
onready var pivot=get_parent().get_parent().get_node("pivot")
onready var line2d_bottom=pivot.get_node("Line2D_bottom")

func _draw():
	var colour=material.set_shader_param("colour",Color(0.8,0.3,0.2,0.9))
	var flash_speed=material.set_shader_param("flash_speed",float(3.0))
	var current_line2d_point=line2d_bottom.to_global(line2d_bottom.get_point_position(line2d_bottom.get_point_count()-1))
	
	draw_line(current_line2d_point,get_global_mouse_position(),Color(1,0,0),thickness,true)



func _input(event):
	
	update()
	
#	var perp_vector=Vector2()
#	var current_line2d_point=pivot.to_global(line2d_bottom.get_point_position(line2d_bottom.get_point_count()-1))
#	var current_mouse_pos=get_global_mouse_position()
#	var preview_line_vector=(current_mouse_pos-current_line2d_point).normalized()
#	perp_vector=Vector3(preview_line_vector.x,preview_line_vector.y,0).cross(Vector3(0,0,1)) # vector which contains direction of polygon thickness
#	polygon[0]=current_line2d_point-Vector2(perp_vector.x,perp_vector.y)*thickness
#	polygon[1]=current_line2d_point+Vector2(perp_vector.x,perp_vector.y)*thickness
#	polygon[2]=current_mouse_pos+Vector2(perp_vector.x,perp_vector.y)*thickness
#	polygon[3]=current_mouse_pos-Vector2(perp_vector.x,perp_vector.y)*thickness