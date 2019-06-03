extends Node2D


onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")
onready var preload_proxy=preload("res://scenes/proxy_expansion_fan.tscn")

onready var checkbox_expansion_fan=get_parent().get_node("checkboxes/checkbox_expansion_fan")

var horizontal_vector=Vector2(1,0)



var colour=[Color(1,0,0),Color(0,1,0),Color(0,0,1)]
var uvs=[Vector2(),Vector2(),Vector2()]
var triangle_height=70




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _draw_expansion_fan(i,mode):


	var vertices=[]
	var vert_start=global_var.list_point_coords[i]
	var vert1=Vector2(global_var.list_point_coords[i].x,global_var.list_point_coords[i].y)
	var vert2=Vector2()
	var expansion_angle1=0
	var expansion_angle2=0


	#var proxy1=preload_proxy.instance()
	#var proxy2=preload_proxy.instance()
	#add_child(proxy1)
	#add_child(proxy2)


	#if mode=="plates":
	if i==0: ### STARTING PLATE (BOTTOM IN THIS CASE). THIS FUNCTION IS USESELESS (POINTLESS AS NEVER GOING TO OCCUR FOR AOA >=0), REMOVE IT 
		vert_start=global_var.list_point_coords[i]

		expansion_angle1=asin(1/global_var.m1)
		vert1=vert_start+(Vector2(1,0).rotated(expansion_angle1)*triangle_height)

		expansion_angle2=asin(1/global_var.list_m[i])
		vert2=vert_start+(global_var.list_vector[i].rotated(expansion_angle2)*triangle_height)

	if i>0 and global_var.list_position[i]==global_var.list_position[i-1]:###IN-BETWEEN PLATES (TOP OR BOTTOM)
		if global_var.list_position[i]=="below" and global_var.list_m[i-1]>0 and global_var.list_m[i]>0: ####'and global_var.list_m[i-1]>0 and global_var.list_m[i]>0' is a safety mechansim to prevent prog crash if 0 (as asin (1/0=>crash)))'
			#if i<line2d_bottom.get_point_count()-1:
			vert_start=global_var.list_point_coords[i]

			expansion_angle1=asin(1/global_var.list_m[i-1])
			vert1=vert_start+(global_var.list_vector[i-1].rotated(expansion_angle1)*triangle_height)

			expansion_angle2=asin(1/global_var.list_m[i])
			vert2=vert_start+(global_var.list_vector[i].rotated(expansion_angle2)*triangle_height)



		if global_var.list_position[i]=="above" and global_var.list_m[i-1]>0 and global_var.list_m[i]>0: ####'and global_var.list_m[i-1]>0 and global_var.list_m[i]>0' is a safety mechansim to prevent prog crash if 0 (as asin (1/0=>crash)))'
			#if i>line2d_bottom.get_point_count()-1:
			vert_start=global_var.list_point_coords[i+1]

			expansion_angle1=-asin(1/global_var.list_m[i-1])
			vert1=vert_start+(global_var.list_vector[i-1].rotated(expansion_angle1)*triangle_height)

			expansion_angle2=-asin(1/global_var.list_m[i])
			vert2=vert_start+(global_var.list_vector[i].rotated(expansion_angle2)*triangle_height)
#
#
	if i>0 and global_var.list_position[i]!=global_var.list_position[i-1] and global_var.list_m[i]>0: ### STARTING TOP PLATE
		vert_start=global_var.list_point_coords[i+1]

		expansion_angle1=-asin(1/global_var.m1)
		vert1=vert_start+(Vector2(1,0).rotated(expansion_angle1)*triangle_height)

		expansion_angle2=-asin(1/global_var.list_m[i])
		vert2=vert_start+(global_var.list_vector[i].rotated(expansion_angle2)*triangle_height)




	vertices=[vert_start,vert1,vert2]

	draw_primitive(vertices,colour,uvs)
	#proxy1.queue_free()
	#proxy2.queue_free()
	
	
func _expansion_at_ending_edge(): # draws exp fan at ending edge
	var index=global_var.index_bottom_top_plate

	if global_var.index_bottom_top_plate>0 and abs(global_var.list_m[index-1])>0:
		var grad=-global_var.list_vector[global_var.index_bottom_top_plate-1].y/global_var.list_vector[global_var.index_bottom_top_plate-1].x
		if sign(grad)==-1: # to prevent exp fan showing if tehre is an oblique shock line
			var vertices=[]
			var vert_start=global_var.list_point_coords[index]
			var vert1=global_var.list_point_coords[index]
			var vert2=Vector2()
			var expansion_angle1=0
			var expansion_angle2=0
			
			
			
			vert_start=global_var.list_point_coords[index]
	
			expansion_angle1=asin(1/global_var.list_m[index-1])
			vert1=vert_start+(global_var.list_vector[index-1].rotated(expansion_angle1)*triangle_height)
	
			#expansion_angle2=-asin(1/global_var.list_m[i])
			vert2=vert_start+(Vector2(1,0)*triangle_height)
	
	
			vertices=[vert_start,vert1,vert2]
			draw_primitive(vertices,colour,uvs)


	
func _draw():
	for i in len(global_var.list_strings):
		if global_var.list_strings[i]=="expansion":
			_draw_expansion_fan(i,"") # draw exp everywhere except at ending edge
	
	_expansion_at_ending_edge() # draws exp fan at the ending edge
	
	
	

func _on_alpha_slider_value_changed(value):
	if checkbox_expansion_fan.pressed==true:
		update()
	pass # Replace with function body.


func _on_checkbox_expansion_fan_toggled(button_pressed):
	visible=button_pressed
	pass # Replace with function body.







func _on_m_slider_button_button_up():
	if checkbox_expansion_fan.pressed==true:
		if (global_var.bow_shock_angle+1)!=1.1:
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			update()
			#print(global_var.list_p_p1,"  ",global_var.list_weak_shock_angle)
	pass # Replace with function body.


func _on_gamma_slider_button_button_up():
	if checkbox_expansion_fan.pressed==true:
		if (global_var.bow_shock_angle+1)!=1.1:
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			update()
			#print(global_var.list_p_p1,"  ",global_var.list_weak_shock_angle)
	pass # Replace with function body.
