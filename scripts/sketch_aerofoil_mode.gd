#Copyright (c) 2019 Mehdi Msayib#
extends Node2D


onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=pivot.get_node("Line2D_bottom")
onready var preload_collison_node=preload("res://scenes/collision_node.tscn")
onready var flashing_green_box=preload("res://scenes/flashing_green_box.tscn")
onready var label_with_timer=preload("res://scenes/label_with_timer.tscn")
onready var rich_text_scene=preload("res://scenes/rich_text.tscn")
onready var undo_button=get_parent().get_node("button_undo")
onready var finish_button=get_parent().get_node("finish_button")
onready var button_restart=get_parent().get_node("button_restart")
	
	
	
func _ready():
	#get_node("Label2").text=str(OS.has_touchscreen_ui_hint())+": has touch screen"
	var viewport_vec=global_var.viewport_vec
	var xCoord1=clamp(100,0,viewport_vec.x*0.5)
	var yCoord1=viewport_vec.y*0.5
	line2d_bottom.add_point(line2d_bottom.to_local(Vector2(xCoord1,yCoord1)))
	_add_collision_node(Vector2(xCoord1,yCoord1))
	
	var rich_text=rich_text_scene.instance()
	rich_text.text="Starting node"
	add_child(rich_text)
	rich_text.rect_global_position=Vector2(xCoord1-rich_text.rect_size.x*0.5,yCoord1-30)
	
func _add_collision_node(coord):
	#if global_var.finish_button_hover==false:
	var preload_collision_node_instance=preload_collison_node.instance()
	line2d_bottom.add_child(preload_collision_node_instance)
	preload_collision_node_instance.rect_global_position=coord-preload_collision_node_instance.rect_size*0.5
	
	
func _hover_button(button, padding):# this function the mouse is over a button. The 'button' argument is the button under question, and 'padding' refers the amount of margin (in pixels) arounf the button
	if get_global_mouse_position().x>= button.rect_global_position.x-padding and  get_global_mouse_position().x <=button.rect_global_position.x+undo_button.rect_size.x+padding:
		if get_global_mouse_position().y>= button.rect_global_position.y-padding and  get_global_mouse_position().y <=button.rect_global_position.y+button.rect_size.y+padding:
			return true
		else:
			return false
	else:
		return false
	pass	
	
	
func _input(event):
	
	if event is InputEventScreenTouch:
		if event.pressed==false and _hover_button(undo_button,10)==false  and _hover_button(finish_button,20)==false and _hover_button(button_restart,20)==false and global_var.aerofoil_choice=="draw":
			#viewport_vec=get_viewport().size
			get_node("Label").text=str(event.pressed)+str(event.index)
			var viewport_vec=global_var.viewport_vec
			
			if (line2d_bottom.get_point_count()<3 and event.position.y>pivot.global_transform.origin.y) or line2d_bottom.get_point_count()>=3: # check if 2nd point is below the neutral line
				
				var xCoord=clamp(event.position.x,0,viewport_vec.x)
				var yCoord=event.position.y
				line2d_bottom.add_point(line2d_bottom.to_local(Vector2(xCoord,yCoord)))
				_add_collision_node(Vector2(xCoord,yCoord))
						
						
			if line2d_bottom.get_point_count()<3 and event.position.y<pivot.global_transform.origin.y:# check if 2nd point above the neutral line then display green rect and error text
				var flashing_box=flashing_green_box.instance()
				add_child(flashing_box)
				#print(44)
				var label=label_with_timer.instance()
				label.get_node("Timer").wait_time=10
				add_child(label)
				label.text="Start by drawing the aerofoil in the green rectangle, then move above the dashed green line and back to the starting point"
				label.rect_size=Vector2(300,100)
				label.rect_global_position=get_viewport().size*0.5 +Vector2(-label.rect_size.x*0.5,20)
				
	
	
	
	
	
	else:
		if event.is_action_released("l_click") and _hover_button(undo_button,10)==false  and _hover_button(finish_button,20)==false and _hover_button(button_restart,20)==false and global_var.aerofoil_choice=="draw":
			#viewport_vec=get_viewport().size
			get_node("Label").text="l click"
			var viewport_vec=global_var.viewport_vec
			
			if (line2d_bottom.get_point_count()<3 and get_global_mouse_position().y>pivot.global_transform.origin.y) or line2d_bottom.get_point_count()>=3: # check if 2nd point is below the neutral line
				
				var xCoord=clamp(get_global_mouse_position().x,0,viewport_vec.x)
				var yCoord=get_global_mouse_position().y
				line2d_bottom.add_point(line2d_bottom.to_local(Vector2(xCoord,yCoord)))
				_add_collision_node(Vector2(xCoord,yCoord))
						
						
			if line2d_bottom.get_point_count()<3 and get_global_mouse_position().y<pivot.global_transform.origin.y:# check if 2nd point above the neutral line then display green rect and error text
				var flashing_box=flashing_green_box.instance()
				add_child(flashing_box)
				#print(44)
				var label=label_with_timer.instance()
				label.get_node("Timer").wait_time=10
				add_child(label)
				label.text="Start by drawing the aerofoil in the green rectangle, then move above the dashed green line and back to the starting point"
				label.rect_size=Vector2(300,100)
				label.rect_global_position=get_viewport().size*0.5 +Vector2(-label.rect_size.x*0.5,20)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
#	if event is InputEventMouseButton:
#		if event.button_index==1: # make sure LMB is used
#			if event.pressed==false: #make sure LMB released
#				if _hover_button(undo_button,10)==false  and _hover_button(finish_button,20)==false and _hover_button(button_restart,20)==false and global_var.aerofoil_choice=="draw":
#					#viewport_vec=get_viewport().size
#					var viewport_vec=global_var.viewport_vec
#
#					if (line2d_bottom.get_point_count()<3 and get_global_mouse_position().y>pivot.global_transform.origin.y) or line2d_bottom.get_point_count()>=3: # check if 2nd point is below the neutral line
#
#						var xCoord=clamp(get_global_mouse_position().x,0,viewport_vec.x)
#						var yCoord=get_global_mouse_position().y
#						line2d_bottom.add_point(line2d_bottom.to_local(Vector2(xCoord,yCoord)))
#						_add_collision_node(Vector2(xCoord,yCoord))
#
#
#					if line2d_bottom.get_point_count()<3 and get_global_mouse_position().y<pivot.global_transform.origin.y:# check if 2nd point above the neutral line then display green rect and error text
#						var flashing_box=flashing_green_box.instance()
#						add_child(flashing_box)
#						#print(44)
#						var label=label_with_timer.instance()
#						label.get_node("Timer").wait_time=10
#						add_child(label)
#						label.text="Start by drawing the aerofoil in the green rectangle, then move above the dashed green line and back to the starting point"
#						label.rect_size=Vector2(300,100)
#						label.rect_global_position=get_viewport().size*0.5 +Vector2(-label.rect_size.x*0.5,20)
		
		
#		if event.pressed==false and _hover_button(undo_button,10)==false  and _hover_button(finish_button,20)==false and _hover_button(button_restart,20)==false and global_var.aerofoil_choice=="draw":
#			#viewport_vec=get_viewport().size
#			var viewport_vec=global_var.viewport_vec
#
#			if (line2d_bottom.get_point_count()<3 and get_global_mouse_position().y>pivot.global_transform.origin.y) or line2d_bottom.get_point_count()>=3: # check if 2nd point is below the neutral line
#
#				var xCoord=clamp(get_global_mouse_position().x,0,viewport_vec.x)
#				var yCoord=get_global_mouse_position().y
#				line2d_bottom.add_point(line2d_bottom.to_local(Vector2(xCoord,yCoord)))
#				_add_collision_node(Vector2(xCoord,yCoord))
#
#
#			if line2d_bottom.get_point_count()<3 and get_global_mouse_position().y<pivot.global_transform.origin.y:# check if 2nd point above the neutral line then display green rect and error text
#				var flashing_box=flashing_green_box.instance()
#				add_child(flashing_box)
#				#print(44)
#				var label=label_with_timer.instance()
#				label.get_node("Timer").wait_time=10
#				add_child(label)
#				label.text="Start by drawing the aerofoil in the green rectangle, then move above the dashed green line and back to the starting point"
#				label.rect_size=Vector2(300,100)
#				label.rect_global_position=get_viewport().size*0.5 +Vector2(-label.rect_size.x*0.5,20)