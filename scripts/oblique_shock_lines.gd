#Copyright (c) 2019 Mehdi Msayib#
extends Node2D

var m_dataset=global_var.m_dataset
var p_p0_dataset=global_var.p_p0_dataset
var theta_dataset=global_var.theta_dataset



var line_length=90
var line_thickness=4
var interpolator=0
var colour=Color()
var end_point=Vector2()



onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")

onready var checkbox_oblique_shock=get_parent().get_node("checkboxes/checkbox_oblique_shock")





func _draw_oblique_shock(i,mode):#done CHANGE PRESSURE RATIO AT BACK (IS NOT ==1)


	var weak_shock_angle=global_var.list_weak_shock_angle[i]
	var ySign=1
	var starting_point=global_var.list_point_coords[i]
	var copy_list_p_p1=[]
	
	for ii in len(global_var.list_strings):
		if global_var.list_strings[i]=="contraction":
			copy_list_p_p1.append(global_var.list_p_p1[ii])
	
	
	copy_list_p_p1.push_back(global_var.p2_p1_END_EDGE_BOTTOM) #######CHECK THIS...	
	copy_list_p_p1.push_back(global_var.p2_p1_END_EDGE_TOP) #######CHECK THIS...
	var max_p_p1=global_var._max(copy_list_p_p1)
	
	if max_p_p1>0: # to ensure we don't / by 0
		var normalized_p_p1=(copy_list_p_p1[i]/max_p_p1)
		
	
	
		if global_var.list_position[i]=="below":
			ySign=1
		if global_var.list_position[i]=="above":
			ySign=-1
		
		if mode=="plates":
			if global_var.list_position[i]=="below":
				starting_point=global_var.list_point_coords[i]
	
			if global_var.list_position[i]=="above":
				starting_point=global_var.list_point_coords[i+1]
	
			end_point=starting_point+Vector2(cos(weak_shock_angle),sin(weak_shock_angle)*ySign)*line_length
	
		if mode=="top end edge":
			normalized_p_p1=copy_list_p_p1.back()/max_p_p1
			starting_point=global_var.list_point_coords[global_var.index_bottom_top_plate]
			end_point=starting_point+Vector2(cos(global_var.weak_shock_END_EDGE_TOP),-sin(global_var.weak_shock_END_EDGE_TOP))*line_length
			
			
			
		if mode=="bottom end edge":
			normalized_p_p1=copy_list_p_p1[len(copy_list_p_p1)-2]/max_p_p1
			starting_point=global_var.list_point_coords[global_var.index_bottom_top_plate]
			end_point=starting_point+Vector2(cos(global_var.weak_shock_END_EDGE_BOTTOM),sin(global_var.weak_shock_END_EDGE_BOTTOM))*line_length
	
	##############set line colour#####################################
		if normalized_p_p1>0.5 and normalized_p_p1<=1:
			interpolator=normalized_p_p1*2 -1
			colour=Color(0,1,0).linear_interpolate(Color(1,0,0),interpolator)
	
		if normalized_p_p1>=0 and normalized_p_p1<=0.5:
			interpolator=normalized_p_p1*2
			colour=Color(0,0,1).linear_interpolate(Color(0,1,0),interpolator)
	
		draw_line(starting_point,end_point,colour,line_thickness)




func _draw():


	for i in range(len(global_var.list_strings)):
		if global_var.list_strings[i]=="contraction":
			_draw_oblique_shock(i,"plates")
	
		_draw_oblique_shock(0,"top end edge") #draw oblique shock at top surface of trailing edge

		if sign(global_var._plate_gradient(global_var.index_bottom_top_plate-1))==1:
			_draw_oblique_shock(0,"bottom end edge") #draw oblique shock at bottom surface of trailing edge








func _on_alpha_slider_value_changed(value):
	if checkbox_oblique_shock.pressed==true:
		if global_var.bow_shock_angle==10 or (global_var.bow_shock_angle>0 and value<global_var.bow_shock_angle):
			update()

	pass # replace with function body


func _on_checkbox_oblique_shock_toggled(button_pressed):
	visible=button_pressed
	pass # Replace with function body.





func _on_gamma_slider_button_button_up(): # update once the gamma slider is changed
	if checkbox_oblique_shock.pressed==true:
		if float(global_var.bow_shock_angle)!=0.1:
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			update()
			#print(global_var.list_p_p1,"  ",global_var.list_weak_shock_angle)
	pass # Replace with function body.




func _on_m_slider_button_button_up():# update once the flow speed slider is changed
	if checkbox_oblique_shock.pressed==true:
		if float(global_var.bow_shock_angle)!=0.1:
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			yield(get_tree(),"idle_frame")
			update()
			#print(global_var.list_p_p1,"  ",global_var.list_weak_shock_angle)
	pass # Replace with function body.
	
	
	
	
