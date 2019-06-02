extends Node2D
#Copyright Mehdi Msayib#

onready var viewport_vec=global_var.viewport_vec

func _ready():
	
	hide()




func _draw_arrow(line_start,line_end,stroke_thickness):
	
	#var norm_parallel_vector=parallel_vector.normalized()
	var l_start=line_start
	var l_end=line_end
	var line_vector=(Vector3(l_end.x,l_end.y,0)-Vector3(l_start.x,l_start.y,0)).normalized()
	var arrow_height=stroke_thickness*3
	var arrow_width=50
	var trig_vert1=Vector3(l_end.x,l_end.y,0)+line_vector.cross(Vector3(0,0,1))*arrow_height/2
	var trig_vert2=Vector3(l_end.x,l_end.y,0)-line_vector.cross(Vector3(0,0,1))*arrow_height/2
	var trig_vert3=Vector3(l_end.x,l_end.y,0)+line_vector*arrow_width
	var colour=Color(0.3,0.9,0.2)
	
	
	draw_line(l_start,l_end,colour,stroke_thickness)
	draw_primitive([trig_vert1,trig_vert2,trig_vert3],[colour,colour,colour],PoolVector2Array())
	pass

func _draw():
	var stroke_thickness=global_var.m1*6
	var screen_center=Vector2(viewport_vec.x/2,viewport_vec.y/2)
	_draw_arrow(screen_center-Vector2(viewport_vec.x/2,0),screen_center-Vector2(400,0),stroke_thickness)



func _on_m_slider_value_changed(value):
	update()
	pass # replace with function body
