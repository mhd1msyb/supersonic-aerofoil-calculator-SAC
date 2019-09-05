#Copyright (c) 2019 Mehdi Msayib#
extends RayCast2D



onready var pivot=get_parent().get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_parent().get_node("pivot").get_node("Line2D_bottom")
onready var preload_collision_polygon=preload("res://scenes/collision_polygon.tscn")
#onready var button=get_parent().get_parent().get_node("button_edit").get_node("add_nodes")
onready var preload_collision_node=preload("res://scenes/collision_node.tscn")

onready var colshapes=get_parent().get_parent().get_node("colshapes")

onready var collision_bound_thickness=line2d_bottom.width*0.5
onready var collision_bound_debug_thickness=collision_bound_thickness

onready var collision_node_scene=preload("res://scenes/collision_node.tscn")

#onready var highlight_position_along_line_SPRITE=get_parent().get_node("pos_along_line_sprite")

onready var button_edit=get_parent().get_parent().get_node("button_edit")

func _ready():
	_add_collision_polygon()





func _remove_collision_polygon():
	
	for i in colshapes.get_child_count():
		colshapes.get_child(i).queue_free()







func _vector_from_points(index):
	return (line2d_bottom.get_point_position(index+1)-line2d_bottom.get_point_position(index)).normalized()







func _delete_lines():
	var count=0
	var point_count=line2d_bottom.get_point_count()
	if point_count>0:
		for i in range (1,line2d_bottom.get_point_count()):
			line2d_bottom.remove_point(point_count-i) # delete lines
		line2d_bottom.remove_point(0)

#		for i in line2d_bottom.get_child_count():
#			line2d_bottom.get_child(i).queue_free()
			






func _find_index_change():
	
	for i in (line2d_bottom.get_point_count()-1):
		if line2d_bottom.get_point_position(i+1).x-line2d_bottom.get_point_position(i).x<0:
			return i
			break






func _add_collision_polygon():
	#for i in range(line2d_bottom.get_point_count()-1):
	var perp_vector=Vector2()
	var old_vec=Vector2()
	
	var index_bottom_top_change=_find_index_change()
	for i in range(line2d_bottom.get_point_count()-1):
		var polygon=preload_collision_polygon.instance()

			
			
		if i<line2d_bottom.get_point_count()-2:
			
			perp_vector=Vector3(_vector_from_points(i).x,_vector_from_points(i).y,0).cross(Vector3(0,0,1)) # vector which contains direction of polygon thickness
			###collision polygon###
			polygon.get_node("CollisionPolygon2D").polygon[0]=line2d_bottom.to_global(line2d_bottom.get_point_position(i))-Vector2(perp_vector.x,perp_vector.y)*collision_bound_thickness
			polygon.get_node("CollisionPolygon2D").polygon[1]=line2d_bottom.to_global(line2d_bottom.get_point_position(i))+Vector2(perp_vector.x,perp_vector.y)*collision_bound_thickness
			polygon.get_node("CollisionPolygon2D").polygon[2]=line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))+Vector2(perp_vector.x,perp_vector.y)*collision_bound_thickness
			polygon.get_node("CollisionPolygon2D").polygon[3]=line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))-Vector2(perp_vector.x,perp_vector.y)*collision_bound_thickness
			
			###flashing green polygon###
			polygon.get_node("Polygon2D_for_debugging").polygon[0]=line2d_bottom.to_global(line2d_bottom.get_point_position(i))-Vector2(perp_vector.x,perp_vector.y)*collision_bound_debug_thickness
			polygon.get_node("Polygon2D_for_debugging").polygon[1]=line2d_bottom.to_global(line2d_bottom.get_point_position(i))+Vector2(perp_vector.x,perp_vector.y)*collision_bound_debug_thickness
			polygon.get_node("Polygon2D_for_debugging").polygon[2]=line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))+Vector2(perp_vector.x,perp_vector.y)*collision_bound_debug_thickness
			polygon.get_node("Polygon2D_for_debugging").polygon[3]=line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))-Vector2(perp_vector.x,perp_vector.y)*collision_bound_debug_thickness
				
		if i==line2d_bottom.get_point_count()-2:
			perp_vector=Vector3(_vector_from_points(i).x,_vector_from_points(i).y,0).cross(Vector3(0,0,1))
			#print(perp_vector,_vector_from_points(i))
			polygon.get_node("CollisionPolygon2D").polygon[0]=line2d_bottom.to_global(line2d_bottom.get_point_position(i))-Vector2(perp_vector.x,perp_vector.y)*collision_bound_thickness
			polygon.get_node("CollisionPolygon2D").polygon[1]=line2d_bottom.to_global(line2d_bottom.get_point_position(i))+Vector2(perp_vector.x,perp_vector.y)*collision_bound_thickness
			polygon.get_node("CollisionPolygon2D").polygon[2]=line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))+Vector2(perp_vector.x,perp_vector.y)*collision_bound_thickness
			polygon.get_node("CollisionPolygon2D").polygon[3]=line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))-Vector2(perp_vector.x,perp_vector.y)*collision_bound_thickness
#
			polygon.get_node("Polygon2D_for_debugging").polygon[0]=line2d_bottom.to_global(line2d_bottom.get_point_position(i))-Vector2(perp_vector.x,perp_vector.y)*collision_bound_debug_thickness
			polygon.get_node("Polygon2D_for_debugging").polygon[1]=line2d_bottom.to_global(line2d_bottom.get_point_position(i))+Vector2(perp_vector.x,perp_vector.y)*collision_bound_debug_thickness
			polygon.get_node("Polygon2D_for_debugging").polygon[2]=line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))+Vector2(perp_vector.x,perp_vector.y)*collision_bound_debug_thickness
			polygon.get_node("Polygon2D_for_debugging").polygon[3]=line2d_bottom.to_global(line2d_bottom.get_point_position(i+1))-Vector2(perp_vector.x,perp_vector.y)*collision_bound_debug_thickness

		colshapes.add_child(polygon)





func _highlight_position_along_line(index):
	var pos=Geometry.get_closest_point_to_segment_2d(get_global_mouse_position(),line2d_bottom.to_global(line2d_bottom.get_point_position(index+1)),line2d_bottom.to_global(line2d_bottom.get_point_position(index)))
	
	get_parent().get_node("coordinate_on_line_sprite").global_transform.origin=pos
	
	return pos






func _input(event):
	#var store_old_GLOBAL_coords_array=[]
	var store_old_LOCAL_coords_array=[]
	var index=0
	

		
#	if event is InputEventScreenTouch or InputEventScreenDrag: # for touchscreen
#		global_transform.origin=event.position
#	#update()
#
#	if event is InputEventMouse: # for mouse
	global_transform.origin=get_viewport().get_mouse_position()
	
	
	if event is InputEventScreenTouch: # for touchscreen
		if event.pressed==false:
			_remove_collision_polygon()
			_add_collision_polygon()
			
			if is_colliding():
				
				index=get_collider().get_position_in_parent()
				print(get_collider().get_position_in_parent())
	#		
				for i in line2d_bottom.get_point_count():
					store_old_LOCAL_coords_array.append(line2d_bottom.get_point_position(i))
					#store_old_GLOBAL_coords_array.append(line2d_bottom.to_global(line2d_bottom.get_point_position(i)))
					
				store_old_LOCAL_coords_array.insert(index+1,line2d_bottom.to_local(_highlight_position_along_line(index)))
				#store_old_GLOBAL_coords_array.insert(index+1,_highlight_position_along_line(index))
				
				_delete_lines()
				
				for i in len(store_old_LOCAL_coords_array):
					line2d_bottom.add_point(store_old_LOCAL_coords_array[i])
				
				var collision_node=collision_node_scene.instance() #add collision node
				line2d_bottom.add_child_below_node(line2d_bottom.get_child(index),collision_node) #add the collision node in the correct order
				collision_node.rect_global_position=_highlight_position_along_line(index)-collision_node.rect_size*0.5
				
			_remove_collision_polygon()
			_add_collision_polygon()
			
			pass
	
	
	
	
	
	
	
	
	elif event.is_action_pressed("l_click"):# for mouse
		_remove_collision_polygon()
		_add_collision_polygon()
		
		if is_colliding():
			
			index=get_collider().get_position_in_parent()
			print(get_collider().get_position_in_parent())
#		
			for i in line2d_bottom.get_point_count():
				store_old_LOCAL_coords_array.append(line2d_bottom.get_point_position(i))
				#store_old_GLOBAL_coords_array.append(line2d_bottom.to_global(line2d_bottom.get_point_position(i)))
				
			store_old_LOCAL_coords_array.insert(index+1,line2d_bottom.to_local(_highlight_position_along_line(index)))
			#store_old_GLOBAL_coords_array.insert(index+1,_highlight_position_along_line(index))
			
			_delete_lines()
			
			for i in len(store_old_LOCAL_coords_array):
				line2d_bottom.add_point(store_old_LOCAL_coords_array[i])
			
			var collision_node=collision_node_scene.instance() #add collision node
			line2d_bottom.add_child_below_node(line2d_bottom.get_child(index),collision_node) #add the collision node in the correct order
			collision_node.rect_global_position=_highlight_position_along_line(index)-collision_node.rect_size*0.5
			
		_remove_collision_polygon()
		_add_collision_polygon()
#		_delete_nodes_and_line()





	if is_colliding():
		#highlight_position_along_line_SPRITE.show()
		_highlight_position_along_line(get_collider().get_position_in_parent())

		
		
		
		
	if button_edit.pressed==false: # delete everything once edit mode button toggled false
		_remove_collision_polygon()
		get_parent().queue_free()
		
		



#func _draw():
#	draw_line(global_transform.origin,global_transform.origin-Vector2(0,50),Color(1,0,0),2)



























#func _remove_all_point():
#	var count=0
#	var point_count=line2d_bottom.get_point_count()
#
#	for i in range (1,line2d_bottom.get_point_count()):
#		count+=1
#		line2d_bottom.remove_point(point_count-i)
#	line2d_bottom.remove_point(0)
#
#
#
#
#func _find_collision_box_index():
#
#	var index=0
#
#	for i in range(button.get_child_count()):
#		if get_collider().name==button.get_child(i).name:
#			index=i
#			break
#
#	return index
#
#
#
#
#func _re_add_points(list_point_coords):
#	for i in range(len(list_point_coords)):
#		line2d_bottom.add_point(pivot.to_local(list_point_coords[i]))
#
#
#
#
#func _remove_collision_shapes():
#
#
#		###delete collision shapes###
#	for i in range (button.get_child_count()):
#		button.get_child(i).queue_free()
#
#
#func _remove_collision_nodes():
#
#	for i in range (1,pivot.get_child_count()):
#		pivot.get_child(i).queue_free()
#
#
#
#func _add_collision_shapes():
#
#	#####add collision shapes + adjust vertices####
#	var collision_box_thickness=0.01
#
#	for i in range (line2d_bottom.get_point_count()-1):
#		var collision_poly=preload_collision_poly.instance()
#		button.add_child(collision_poly)
#		collision_poly.global_transform.origin=Vector2(0,0)
#
#
#		collision_poly.get_child(0).polygon[0]=pivot.to_global(line2d_bottom.get_point_position(i))+Vector2(0,collision_box_thickness)
#		collision_poly.get_child(0).polygon[1]=pivot.to_global(line2d_bottom.get_point_position(i))+Vector2(0,-collision_box_thickness)
#		collision_poly.get_child(0).polygon[2]=pivot.to_global(line2d_bottom.get_point_position(i+1))+Vector2(0,-collision_box_thickness)
#		collision_poly.get_child(0).polygon[3]=pivot.to_global(line2d_bottom.get_point_position(i+1))+Vector2(0,collision_box_thickness)
#
#
#
#
#func _add_collision_nodes():
#
#	for i in range (line2d_bottom.get_point_count()-1):
#		var collision_node=preload_collision_node.instance()
#		pivot.add_child(collision_node)
#		collision_node.rect_global_position=pivot.to_global(line2d_bottom.get_point_position(i))-collision_node.rect_size*0.5
#
#	#print(pivot.get_children())
#
#
#func _coordinate(): #sets the coordinate to ALWAYS lie on the line
#
#	var index=_find_collision_box_index()
#	var line_pt1=pivot.to_global(line2d_bottom.get_point_position(index))
#	var line_pt2=pivot.to_global(line2d_bottom.get_point_position(index+1))
#
#	var line_x_diff=line_pt2.x-line_pt1.x
#	var current_x_diff=get_collision_point().x-line_pt1.x
#
#	var interp_val=current_x_diff/line_x_diff
#
#	var actualPOINT=line_pt1.linear_interpolate(line_pt2,interp_val)
#
#	return actualPOINT
#	#sprite_point.global_transform.origin=actualPOINT
#
#
#
#
#func _ready():
#	_remove_collision_shapes()
#	_add_collision_shapes()
#	#print(line2d_bottom.get_point_count())
#
#
#
#
#
#func _coordinate_on_line_sprite_visualiser(): # moves the '_coordinate_on_line_sprite' along the lines 
#
#	if is_colliding():
#		get_parent().get_child(1).global_transform.origin=_coordinate()
#
#
#
#func _remove_duplicate_entries():
#	for i in range (line2d_bottom.get_point_count()):
#		if i<line2d_bottom.get_point_count()-1:
#			if line2d_bottom.get_point_position(i)==line2d_bottom.get_point_position(i+1) and line2d_bottom.get_point_position(i).y==line2d_bottom.get_point_position(i+1).y:
#				line2d_bottom.remove_point(i+1)
#				print(8768678678687678687)
#
#
#
#func _input(event):
#
#	global_transform.origin=get_global_mouse_position()-Vector2(0,5)
#
#	_coordinate_on_line_sprite_visualiser()
#
#	var list_point_coords=[]
#
#
#
#	if is_colliding() and event.is_action_pressed("l_click") and global_var.move_node_mode==false:
#
#		_remove_duplicate_entries()
#
#		for i in range(line2d_bottom.get_point_count()):
#			list_point_coords.append(pivot.to_global(line2d_bottom.get_point_position(i)))
#
#		#update list_point_coords list to accomodate the new added point
#		list_point_coords.insert(_find_collision_box_index()+1,_coordinate())
#
#
#		#delete all points on the Line2D (i.e. reset the Line2D)
#		_remove_all_point()
#
#		#draw lines again (add points back to Line2D
#		_re_add_points(list_point_coords)
#		#delete any old collision shapes (from the previous iteration
#		_remove_collision_shapes()
#		_remove_collision_nodes() #remove old col nodes
#
#		#create new collision shapes for the updated geometry
#		_add_collision_shapes()
#		_add_collision_nodes() #add new col nodes
#
#		#print(pivot.get_children())
		
		
		
		
		


