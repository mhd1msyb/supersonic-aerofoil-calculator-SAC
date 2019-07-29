#Copyright (c) 2019 Mehdi Msayib#
extends Button

"""

0-add
1-del
2-move
3-chord
4-thick

"""

onready var add_node_mode=preload("res://scenes/add_node_mode.tscn")
onready var label_with_timer=preload("res://scenes/label_with_timer.tscn")

onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=pivot.get_node("Line2D_bottom")
onready var alpha_slider=get_parent().get_node("alpha_slider")
onready var m_slider=get_parent().get_node("m_slider_button")
onready var gamma_slider=get_parent().get_node("gamma_slider_button")


onready var chord_slider=get_parent().get_node("chord_slider")
onready var thickness_slider=get_parent().get_node("thickness_slider")

onready var move_nodes_scene=preload("res://scenes/move_node_mode.tscn")
onready var delete_nodes_scene=preload("res://scenes/delete_nodes.tscn")



func _ready():
	disabled=true
	pass






func _on_PopupMenu_index_pressed(index):
	
	if index==0:#add node
		var add_node=add_node_mode.instance()
		get_parent().add_child(add_node)
	
	if index==1:#delete node:
		var delete_node=delete_nodes_scene.instance()
		get_parent().add_child(delete_node)
	
	if index==2:#move node:
		var move_node=move_nodes_scene.instance()
		get_parent().add_child(move_node)
	
	if index==3:# chord slider
		chord_slider.show()
		chord_slider.get_node("chord_slider").value=0

	if index==4:# thickness slider
		thickness_slider.show()
		thickness_slider.get_node("thickness_slider").value=0
	
	pass # Replace with function body.




func _on_button_edit_toggled(button_pressed):
	
	if button_pressed==true: # set AoA to 0 when in edit mode
		#pivot.global_rotation=global_var.alpha_offset
		alpha_slider.hide()
		m_slider.hide()
		gamma_slider.hide()
	else:# reset AoA back to original value when exit edit mode
		if (global_var.bow_shock_angle+1)==1.1:
			alpha_slider.hide()
			m_slider.hide()
			gamma_slider.hide()
		else:
			#pivot.global_rotation_degrees=alpha_slider.value
			alpha_slider.show()
			m_slider.show()
			gamma_slider.show()
			
	get_node("CanvasLayer/PopupMenu").visible=button_pressed
	
	if chord_slider.visible:
		chord_slider.hide()
	if thickness_slider.visible:
		thickness_slider.hide()
	
	
	pass # Replace with function body.














#func _remove_move_node_scene():
#	for i in range(get_child_count()):
#		if get_child(i).name=="drag_nodes":
#			get_child(i).queue_free()
#			break
#
#
#
#
#
#func _remove_delete_nodes_scene():
#	for i in range(get_child_count()):
#		if get_child(i).name=="delete_nodes":
#			get_child(i).queue_free()
#			break
#
#
#func _remove_raycast_scene():
#
#	for i in range(get_parent().get_child_count()):
#		if get_parent().get_child(i).name=="RayCast2D":
#			get_parent().get_child(i).queue_free()
#			break
#
#
#
#
#func _on_button_edit_toggled(button_pressed):
#	if global_var.alpha_radians==0:
#
#		global_var.edit_mode=button_pressed
#		get_child(0).visible=button_pressed
#
#		chord_slider.hide()
#		thickness_slider.hide()
#
#		_remove_move_node_scene()
#
#		_remove_delete_nodes_scene()
#
#		_remove_raycast_scene()
#
#	else: # show error message if AoA is not =0
#		var label=label_with_timer.instance()
#		get_parent().add_child(label)
#		label.rect_global_position=get_viewport().size*0.5+Vector2(0,30)
#		label.text="Set 'Angle of Attack' slider to 0, then click 'EDIT' again."
#
#
#
#	if button_pressed==true and global_var.alpha_radians==0: #to prevent aerofoil from being rotated during edit mode
#		alpha_slider.hide()
#
#	else:
#		alpha_slider.show()
#
#
#func _on_PopupMenu_index_pressed(index):
#	print(global_var.shift_midpoint)
#
#
#	if index==0: #add nodes
#		var raycas=raycast_scene.instance()
#		get_parent().add_child(raycas)
#		global_var.move_node_mode=false
#
#
#
#
#
#	if index==1: #delete nodes
#		var delete_nodes=delete_nodes_scene.instance()
#		add_child(delete_nodes)
#
#
#
#
#
#
#
#	if index==2: #move nodes
#		var drag_nodes=drag_nodes_scene.instance()
#		line2d_bottom.add_child(drag_nodes)
#		global_var.move_node_mode=true
#
#
#
#
#
#
#	if index==3:# chord length
#		chord_slider.show()
#	else:
#		chord_slider.hide()
#
#
#
#
#
#
#
#
#	if index==4: #thickness
#		thickness_slider.show()
#	else:
#		thickness_slider.hide()









