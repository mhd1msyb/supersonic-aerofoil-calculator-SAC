#Copyright (c) 2019 Mehdi Msayib#
extends Node2D


onready var preload_collison_node=preload("res://scenes/collision_node.tscn")
onready var label_with_timer=preload("res://scenes/label_with_timer.tscn")

onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")
onready var button_done=get_node("button_done")
onready var button_cancel=get_node("button_cancel")
var index = -1 # -1 means that no node is selected




func _ready():
	pass # Replace with function body.


func _delete_lines_and_nodes():
	var count=0
	var point_count=line2d_bottom.get_point_count()
	if point_count>0:
		for i in range (1,line2d_bottom.get_point_count()):
			line2d_bottom.remove_point(point_count-i) # delete lines
		line2d_bottom.remove_point(0)

		for i in line2d_bottom.get_child_count(): #delete nodes
			line2d_bottom.get_child(i).queue_free()


func _add_collision_node(coord):
	#if global_var.finish_button_hover==false:
	var preload_collision_node_instance=preload_collison_node.instance()
	line2d_bottom.add_child(preload_collision_node_instance)
	preload_collision_node_instance.rect_global_position=coord-preload_collision_node_instance.rect_size*0.5






func _input(event):
	if event is InputEventMouseButton:
		update()
	
func _draw():
	for i in line2d_bottom.get_children():
		if i.pressed and i.get_position_in_parent()!=0 and i.get_position_in_parent()!=global_var.index_bottom_top_plate:
			var curve2d=Curve2D.new()
			curve2d.bake_interval=60.0
			
			index=i.get_position_in_parent()
			

			
			#draw_polyline(curve2d.get_baked_points(),ColorN("springgreen",1.0),8.0)
			
			var mp1=(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1))+line2d_bottom.to_global(line2d_bottom.get_point_position(index)))*0.5
			var mp2=(line2d_bottom.to_global(line2d_bottom.get_point_position(index))+line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))*0.5
			
			
#			var nor_vec1=(line2d_bottom.get_point_position(index)-line2d_bottom.get_point_position(index-1)).normalized().tangent()
#			var nor_vec2=(line2d_bottom.get_point_position(index+1)-line2d_bottom.get_point_position(index)).normalized().tangent()
#			var handle_vec=((nor_vec1+nor_vec2)*0.5).tangent()
			
			var handle_vec=((line2d_bottom.get_point_position(index)-line2d_bottom.get_point_position(index-1)).normalized()+(line2d_bottom.get_point_position(index+1)-line2d_bottom.get_point_position(index)).normalized())*0.5
			
			if sign(handle_vec.x)==1:
				draw_line( mp1 ,  mp1-handle_vec*100 ,ColorN("orangered",1.0),8.0)
				draw_line( mp1 ,  mp1+handle_vec*100 ,ColorN("springgreen",1.0),8.0)
			if sign(handle_vec.x)==-1:
				draw_line( mp1 ,  mp1+handle_vec*100 ,ColorN("orangered",1.0),8.0)
				draw_line( mp1 ,  mp1-handle_vec*100 ,ColorN("springgreen",1.0),8.0)
#			draw_line( mp1 ,  mp1+nor_vec1*100 ,ColorN("orangered",1.0),8.0)
#			draw_line( mp1 ,  mp1-handle_vec*100 ,ColorN("orangered",1.0),8.0)
#			draw_line( mp1 ,  mp1+handle_vec*100 ,ColorN("springgreen",1.0),8.0)
			
			var handle_1=line2d_bottom.to_global(line2d_bottom.get_point_position(index))-handle_vec*100
			var handle_2=line2d_bottom.to_global(line2d_bottom.get_point_position(index))+handle_vec*100
			
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)))
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index)),Vector2(-100,0),Vector2(100,0))
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))
			#draw_line( mp1 ,  mp1-global_var.list_vector[index-1].tangent()*100 ,ColorN("springgreen",1.0),8.0)
			
			
			#draw_line(handle_vec+Vector2(100,100),handle_vec*100+Vector2(100,100),ColorN("springgreen",1.0),1.0)
			#draw_line( line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)) ,  line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)) ,ColorN("orangered",1.0),8.0)
			#print(array[0], "  ",curve2d.get_baked_points())
			
		elif i.pressed and (i.get_position_in_parent()==0 or i.get_position_in_parent()==global_var.index_bottom_top_plate): # add error message
			index=-1
			
			var error_message=label_with_timer.instance()
			error_message.self_modulate=ColorN("orangered",1.0)
			error_message.rect_global_position=button_done.rect_global_position+Vector2(0,-40)
			error_message.rect_size.x*=2.0
			error_message.text="Error: Start and end nodes cannot be used. Try selecting other nodes"
			add_child(error_message)
			
			
			
			
			
			
			
			
			

func _on_button_done_pressed():
	var store_old_LOCAL_coords_array=[]
	var curve2d_baked_points=[]
	
	if index!=-1:
		var curve2d=Curve2D.new()
		curve2d.bake_interval=60.0
		
		#var handle_vec=(global_var.list_vector[index].tangent()+global_var.list_vector[index-1].tangent())*0.5
		
		
		
		var handle_vec=((line2d_bottom.get_point_position(index)-line2d_bottom.get_point_position(index-1)).normalized()+(line2d_bottom.get_point_position(index+1)-line2d_bottom.get_point_position(index)).normalized())*0.5
		
		var handle_1=Vector2()
		var handle_2=Vector2()
		
		
		if sign(handle_vec.x)==1:
			handle_1=handle_vec*100
			handle_2=-handle_vec*100
			
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)))
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index)),handle_2,handle_1)
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))
		if sign(handle_vec.x)==-1:
			handle_1=-handle_vec*100
			handle_2=handle_vec*100
			
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)))
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index)),handle_1,handle_2)
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))
#		curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)))
#		curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index)),handle_2,handle_1)
#		curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))
		
		
		
		curve2d_baked_points=curve2d.get_baked_points()
		curve2d_baked_points.remove(0)
		curve2d_baked_points.remove(curve2d_baked_points.size()-1)
		
		
		
		for i in line2d_bottom.get_point_count():
			if i==index:
				for ii in curve2d_baked_points:
					store_old_LOCAL_coords_array.append(line2d_bottom.to_local(ii))
			else:
				store_old_LOCAL_coords_array.append(line2d_bottom.get_point_position(i))
		
		
		_delete_lines_and_nodes()
		
		
		for i in len(store_old_LOCAL_coords_array):
			line2d_bottom.add_point(store_old_LOCAL_coords_array[i])
			
			if i<len(store_old_LOCAL_coords_array)-1: #add collision nodes
				var coord=line2d_bottom.to_global(store_old_LOCAL_coords_array[i])
				_add_collision_node(coord)
		
		print(line2d_bottom.points)
		
	pass # Replace with function body.
	
	
	
	
	
	
	
	
	
	
	
	

func _on_button_cancel_pressed():
	queue_free()
	pass # Replace with function body.
