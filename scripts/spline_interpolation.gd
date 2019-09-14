#Copyright (c) 2019 Mehdi Msayib#
extends Node2D


onready var preload_collison_node=preload("res://scenes/collision_node.tscn")
onready var label_with_timer=preload("res://scenes/label_with_timer.tscn")

onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")
onready var button_done=get_node("HBoxContainer/button_done")
onready var button_finish=get_node("HBoxContainer/button_finish")
onready var button_cancel=get_node("HBoxContainer/button_cancel")
onready var handle_slider=get_node("handle_slider")
var index = -1 # -1 means that no node is selected

onready var handle_length=handle_slider.get_node("HSlider").value


func _ready():
	handle_slider.get_node("Label").text="Handle Slider : "+str(stepify((handle_slider.get_node("HSlider").value-handle_slider.get_node("HSlider").min_value)/(handle_slider.get_node("HSlider").max_value-handle_slider.get_node("HSlider").min_value),0.01))
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
#		if event.button_index==1:
		for i in line2d_bottom.get_children():
			if i.pressed and i.get_position_in_parent()!=0 and i.get_position_in_parent()!=global_var.index_bottom_top_plate:
				index=i.get_position_in_parent()
				update()
				button_done.show()
				button_finish.hide()
			else:
				pass

func _draw():
	if index!=-1:
		var curve2d=Curve2D.new()
		curve2d.bake_interval=60.0
		
#			index=i.get_position_in_parent()
		
	
	#	var mp1=(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1))+line2d_bottom.to_global(line2d_bottom.get_point_position(index)))*0.5
	#	var mp2=(line2d_bottom.to_global(line2d_bottom.get_point_position(index))+line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))*0.5
	
		var handle_vec=((line2d_bottom.get_point_position(index)-line2d_bottom.get_point_position(index-1)).normalized()+(line2d_bottom.get_point_position(index+1)-line2d_bottom.get_point_position(index)).normalized())*0.5
	
	
		var handle_1=Vector2()
		var handle_2=Vector2()
		
		
		if sign(handle_vec.x)==1:
			handle_1=handle_vec*handle_length
			handle_2=-handle_vec*handle_length
			
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)))
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index)),handle_2,handle_1)
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))
			
			draw_polyline(curve2d.get_baked_points(),ColorN("springgreen",1.0),5.0) #draw cuvre preview 
			
			draw_line( line2d_bottom.to_global(line2d_bottom.get_point_position(index)) ,  line2d_bottom.to_global(line2d_bottom.get_point_position(index))-handle_vec*handle_length ,ColorN("antiquewhite",0.9),4.0) # draw left handle
			draw_line( line2d_bottom.to_global(line2d_bottom.get_point_position(index)) ,  line2d_bottom.to_global(line2d_bottom.get_point_position(index))+handle_vec*handle_length ,ColorN("mediumvioletred",0.9),4.0)  # draw right handle
			
			draw_circle(line2d_bottom.to_global(line2d_bottom.get_point_position(index))-handle_vec*handle_length,5.0,ColorN("darkgoldenrod",1.0)) #draw handle knob
			draw_circle(line2d_bottom.to_global(line2d_bottom.get_point_position(index))+handle_vec*handle_length,5.0,ColorN("darkgoldenrod",1.0)) #draw handle knob
			
		if sign(handle_vec.x)==-1:
			handle_1=-handle_vec*handle_length
			handle_2=handle_vec*handle_length
			
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)))
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index)),handle_1,handle_2)
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))
	
			draw_polyline(curve2d.get_baked_points(),ColorN("springgreen",1.0),5.0) #draw cuvre preview 
	
			draw_line( line2d_bottom.to_global(line2d_bottom.get_point_position(index)) ,  line2d_bottom.to_global(line2d_bottom.get_point_position(index))+handle_vec*handle_length ,ColorN("antiquewhite",0.9),4.0)  # draw right handle
			draw_line( line2d_bottom.to_global(line2d_bottom.get_point_position(index)) ,  line2d_bottom.to_global(line2d_bottom.get_point_position(index))-handle_vec*handle_length ,ColorN("mediumvioletred",0.9),4.0)  # draw left handle
	
			draw_circle(line2d_bottom.to_global(line2d_bottom.get_point_position(index))+handle_vec*handle_length,5.0,ColorN("darkgoldenrod",1.0)) #draw handle knob
			draw_circle(line2d_bottom.to_global(line2d_bottom.get_point_position(index))-handle_vec*handle_length,5.0,ColorN("darkgoldenrod",1.0)) #draw handle knob
	
	
	
	
	
	
	#			if sign(handle_vec.x)==1:
	#				draw_line( mp1 ,  mp1-handle_vec*100 ,ColorN("orangered",1.0),8.0)
	#				draw_line( mp1 ,  mp1+handle_vec*100 ,ColorN("springgreen",1.0),8.0)
	#			if sign(handle_vec.x)==-1:
	#				draw_line( mp1 ,  mp1+handle_vec*100 ,ColorN("orangered",1.0),8.0)
	#				draw_line( mp1 ,  mp1-handle_vec*100 ,ColorN("springgreen",1.0),8.0)
		
	
		
	#			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)))
	#			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index)),Vector2(-100,0),Vector2(100,0))
	#			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))
		
		
	#			draw_polyline(curve2d.get_baked_points(),ColorN("springgreen",1.0),5.0)
			
		
#		elif i.pressed and (i.get_position_in_parent()==0 or i.get_position_in_parent()==global_var.index_bottom_top_plate): # add error message
#			index=-1
#
#			var error_message=label_with_timer.instance()
#			error_message.self_modulate=ColorN("orangered",1.0)
#			error_message.rect_global_position=button_done.rect_global_position+Vector2(0,-40)
#			error_message.rect_size.x*=2.0
#			error_message.text="Error: Start and end nodes cannot be used. Try selecting other nodes"
#			add_child(error_message)
			
			
			
			
			
			
			
			

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
			handle_1=handle_vec*handle_length
			handle_2=-handle_vec*handle_length
			
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index-1)))
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index)),handle_2,handle_1)
			curve2d.add_point(line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)))
		if sign(handle_vec.x)==-1:
			handle_1=-handle_vec*handle_length
			handle_2=handle_vec*handle_length
			
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
		
#		print(line2d_bottom.points)

		button_done.hide()
		button_finish.show()
	pass # Replace with function body.
	
	
func _on_HSlider_value_changed(value):
	handle_length=value
	handle_slider.get_node("Label").text="Handle Slider : "+str(stepify((value-handle_slider.get_node("HSlider").min_value)/(handle_slider.get_node("HSlider").max_value-handle_slider.get_node("HSlider").min_value),0.01))
	update()
	pass # Replace with function body.
	
	
	
func _on_button_cancel_pressed():
	queue_free()
	pass # Replace with function body.




func _on_button_finish_pressed():
	pass # Replace with function body.
