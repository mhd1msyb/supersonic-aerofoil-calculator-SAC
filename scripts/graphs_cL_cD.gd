extends Node2D

"""

This node is used for rendering the following plots: cL vs. AoA, cD vs. AoA, cL/cD vs. AoA

"""
onready var rich_text=preload("res://scenes/rich_text.tscn")
onready var preload_proxy=preload("res://scenes/graph_point_sprite.tscn")
onready var subpoints_scene=preload("res://scenes/subpoints.tscn")
onready var draw_curve_scene=preload("res://scenes/draw_curve_thorugh_points.tscn")


onready var indicator_cL=get_node("cL_graph/indicator_cL")
onready var indicator_cD=get_node("cD_graph/indicator_cD")
onready var indicator_cD_div_cL=get_node("cD_div_cL_graph/indicator_cD_div_cL")
onready var indicator_cL_div_cD=get_node("cL_div_cD_graph/indicator_cL_div_cD")

onready var checkbox_hide_everything_except_graphs=get_parent().get_node("checkbox_hide_everything_except_graphs")

onready var pivot=get_parent().get_node("pivot")
onready var show_cL_graph_button=get_parent().get_node("checkboxes/checkbox_cL_plot")
onready var show_cD_graph_button=get_parent().get_node("checkboxes/checkbox_cD_plot")
onready var show_cD_div_cL_graph_button=get_parent().get_node("checkboxes/checkbox_cD_div_cL_plot")
onready var show_cL_div_cD_graph_button=get_parent().get_node("checkboxes/checkbox_cL_div_cD_plot")



onready var cL_graph=get_node("cL_graph")
onready var cD_graph=get_node("cD_graph")
onready var cD_div_cL_graph=get_node("cD_div_cL_graph")
onready var cL_div_cD_graph=get_node("cL_div_cD_graph")





onready var cL_points=get_node("cL_graph").get_node("points")
onready var cL_labels=get_node("cL_graph").get_node("labels")

onready var cD_points=get_node("cD_graph").get_node("points")
onready var cD_labels=get_node("cD_graph").get_node("labels")

onready var cD_div_cL_points=get_node("cD_div_cL_graph").get_node("points")
onready var cD_div_cL_labels=get_node("cD_div_cL_graph").get_node("labels")

onready var cL_div_cD_points=get_node("cL_div_cD_graph").get_node("points")
onready var cL_div_cD_labels=get_node("cL_div_cD_graph").get_node("labels")






onready var cL_x_label=get_node("cL_graph").get_node("labels").get_node("x")
onready var cL_y_label=get_node("cL_graph").get_node("labels").get_node("y")

onready var cD_x_label=get_node("cD_graph").get_node("labels").get_node("x")
onready var cD_y_label=get_node("cD_graph").get_node("labels").get_node("y")

onready var cD_div_cL_x_label=get_node("cD_div_cL_graph").get_node("labels").get_node("x")
onready var cD_div_cL_y_label=get_node("cD_div_cL_graph").get_node("labels").get_node("y")

onready var cL_div_cD_x_label=get_node("cL_div_cD_graph").get_node("labels").get_node("x")
onready var cL_div_cD_y_label=get_node("cL_div_cD_graph").get_node("labels").get_node("y")

var graph_size=700
var point_scale=0.2



	

func _ready():
	
	var rich_text_instance_cL=rich_text.instance()
	cL_labels.add_child(rich_text_instance_cL)
	rich_text_instance_cL.text=str(0)
	
	var rich_text_instance_cD=rich_text.instance()
	cD_labels.add_child(rich_text_instance_cD)
	rich_text_instance_cD.text=str(0)

	var rich_text_instance_cD_div_cL=rich_text.instance()
	cD_div_cL_labels.add_child(rich_text_instance_cD_div_cL)
	rich_text_instance_cD_div_cL.text=str(0)

	var rich_text_instance_cL_div_cD=rich_text.instance()
	cL_div_cD_labels.add_child(rich_text_instance_cL_div_cD)
	rich_text_instance_cL_div_cD.text=str(0)


	_axes_name_label("AoA (deg)", cL_graph,"x")
	_axes_name_label("cL", cL_graph,"y")
	
	_axes_name_label("AoA (deg)", cD_graph,"x")
	_axes_name_label("cD", cD_graph,"y")
	
	
	_axes_name_label("AoA (deg)", cD_div_cL_graph,"x")
	_axes_name_label("cD/cL", cD_div_cL_graph,"y")
	
	
	_axes_name_label("AoA (deg)", cL_div_cD_graph,"x")
	_axes_name_label("cL/cD", cL_div_cD_graph,"y")
	
	
	
func _axes_name_label(name_string,graph,axis):# for adding axis labels, e.g. 'Angle of Attack (radians)' etc.
	
	var rich_text_instance=rich_text.instance()
	rich_text_instance.name=axis+"_axis"
	rich_text_instance.text=name_string
	graph.get_node("labels").add_child(rich_text_instance)
	if axis=="x":
		rich_text_instance.rect_global_position=graph.rect_global_position+Vector2(40,0)
	if axis=="y":
		rich_text_instance.rect_global_position=graph.rect_global_position+Vector2(-20,-40)
	
	

func _add_points(x,y, global_pos,size, graph,parent): #adds the 'points' to the graph
	"""
	x - the x parameter of the graph
	y - the y parameter of the graph
	global_pos - the origin of the graph in global screen space coords
	size - the size of the graph
	
	"""
	var proxy_instance=preload_proxy.instance()
	
	parent.add_child(proxy_instance)
	proxy_instance.material.set_shader_param("random_graph_point_color",global_var.random_graph_point_color)
	proxy_instance.scale=Vector2(1,1)*point_scale
	proxy_instance.global_transform.origin=global_pos + Vector2(x,-y)*size 
	
	
	


func _axes_draw_line(graph_name_string): # draws axes lines

	"""
	draws the x and y axes
	'graph_name_string' argument is the STRING NAME of graph object (i.e. 'cL_graph' or 'cD_graph' etc)
	
	"""
	var graph=get_node(graph_name_string)
	var xcoord_list=[graph.rect_global_position.x]
	var ycoord_list=[graph.rect_global_position.y]

	for i in range(graph.get_node("points").get_child_count()):
		for ii in range(graph.get_node("points").get_child(i).get_child_count()):
			xcoord_list.append(graph.get_node("points").get_child(i).get_child(ii).global_transform.origin.x)
			ycoord_list.append(graph.get_node("points").get_child(i).get_child(ii).global_transform.origin.y)
	
	var maxX=global_var._max(xcoord_list)
	var maxY=global_var._min(ycoord_list)
	
	
	draw_line(graph.rect_global_position,Vector2(maxX,graph.rect_global_position.y),Color(0.2,0.6,1),3) # x line
	draw_line(graph.rect_global_position,Vector2(graph.rect_global_position.x,maxY),Color(0.2,0.6,1),3) # y line
	
	_labels("x",Vector2(maxX,graph.rect_global_position.y+10),str( stepify( rad2deg((maxX-graph.rect_global_position.x)/graph_size),0.01 ) ),graph_name_string) # add x label
	_labels("y",Vector2(graph.rect_global_position.x,maxY),str( stepify( ( (graph.rect_global_position.y-maxY)/graph_size),0.01) ),graph_name_string) # add y label
	
	#_add_aoa_value(maxX,graph)
	
	graph.get_node("labels").get_node("y_axis").rect_global_position=Vector2(graph.rect_global_position.x,maxY)+Vector2(-40,0) #update position of y axis label
	graph.get_node("labels").get_node("x_axis").rect_global_position=Vector2(maxX,graph.rect_global_position.y)+Vector2(40,0) #update position of y axis label
	
	
	
	
#func _add_aoa_value(maxX,graph):
#	var label=rich_text.instance()
#	graph.get_node("labels").add_child(label)
#	label.rect_global_position=Vector2(maxX,graph.rect_global_position.y+10)
#	label.text=str( stepify( rad2deg((maxX-graph.rect_global_position.x)/graph_size),0.01 ) )
	
func _draw():
	if show_cL_graph_button.pressed==true:
		_axes_draw_line("cL_graph")
		update()
		
		
	if show_cD_graph_button.pressed==true:
		_axes_draw_line("cD_graph")
		update()
		
	if show_cD_div_cL_graph_button.pressed==true:
		_axes_draw_line("cD_div_cL_graph")
		update()
		
	if show_cL_div_cD_graph_button.pressed==true:
		_axes_draw_line("cL_div_cD_graph")
		update()
	
	
	pass




func _labels(axis,pos,value,graph_name_string):
	var text_instance=""
	
	if graph_name_string=="cL_graph":
		if axis=="x":
			text_instance=cL_x_label
		if axis=="y":
			text_instance=cL_y_label
			
	if graph_name_string=="cD_graph":
		if axis=="x":
			text_instance=cD_x_label
		if axis=="y":
			text_instance=cD_y_label
			
			
			
	if graph_name_string=="cD_div_cL_graph":
		if axis=="x":
			text_instance=cD_div_cL_x_label
		if axis=="y":
			text_instance=cD_div_cL_y_label
			
			
			
	if graph_name_string=="cL_div_cD_graph":
		if axis=="x":
			text_instance=cL_div_cD_x_label
		if axis=="y":
			text_instance=cL_div_cD_y_label
			
			
			
	text_instance.rect_global_position=pos
	text_instance.text=str(value)

	


	
	
	
	

func _on_checkbox_cL_plot_toggled(button_pressed):
	
	cL_graph.visible=button_pressed
	update()
	pass # replace with function body



func _on_checkbox_cD_plot_toggled(button_pressed):
	
	cD_graph.visible=button_pressed
	update()
	pass # replace with function body


func _on_checkbox_cD_div_cL_plot_toggled(button_pressed):
	cD_div_cL_graph.visible=button_pressed
	update()
	pass # Replace with function body.



func _on_checkbox_cL_div_cD_plot_toggled(button_pressed):
	cL_div_cD_graph.visible=button_pressed
	update()
	pass # Replace with function body.



func _on_button_edit_toggled(button_pressed): #MAIN FUNCTION
	
	
	_update_graph(button_pressed,cL_graph)
	
	_update_graph(button_pressed,cD_graph)
	
	_update_graph(button_pressed,cD_div_cL_graph)
	
	_update_graph(button_pressed,cL_div_cD_graph)
	
	
	
	pass # Replace with function body.



func _add_curve_through_points(sub_points):
	var draw_curve_scene_instance=draw_curve_scene.instance()
	sub_points.add_child(draw_curve_scene_instance)
	#print(sub_points.get_child(2).name)




func _update_graph(button_pressed,graph):
	
	"""
	this function adds the points to the graph if geomtery is changed or/finish button is clicked (also need to 
	accomodate change in speed slider and gamma value, possibly even iteration precision)
	
	"""
	
	
	
	var check_button=null
	var list=[]
	var sub_points=subpoints_scene.instance()
	
	if graph==cL_graph:
		check_button=show_cL_graph_button
		list=global_var.cL_plot_list
		cL_graph.get_node("points").add_child(sub_points)
	if graph==cD_graph:
		check_button=show_cD_graph_button
		list=global_var.cD_plot_list
		cD_graph.get_node("points").add_child(sub_points)
	if graph==cD_div_cL_graph:
		check_button=show_cD_div_cL_graph_button
		list=global_var.cD_div_cL_plot_list
		cD_div_cL_graph.get_node("points").add_child(sub_points)
	if graph==cL_div_cD_graph:
		check_button=show_cL_div_cD_graph_button
		list=global_var.cL_div_cD_plot_list
		cL_div_cD_graph.get_node("points").add_child(sub_points)
	
	if global_var.aerofoil_geomtery_changed==true and check_button.pressed:
		for i in len(list):
			_add_points(global_var.alpha_radians_plot_list[i], list[i] , graph.rect_global_position , graph_size,graph,sub_points)
			
			
		_add_curve_through_points(sub_points)
		
		#_draw_bow_shock_line(graph,sub_points)
		
		
		#print(global_var.cL_plot_list.back())
	#global_var.cL_plot_list.clear()
	#print(graph.get_node("points").get_child_count())


func _indicator(indicator,alpha_radians,coefficient,graph_pos,graph_size): 
	"""
	this function moves the 'indicator' sprite to the current point along the curve
	"""
	indicator.global_transform.origin=graph_pos + Vector2(alpha_radians,-coefficient)*graph_size 
	pass





func _input(event): # to drag the graphs 
	
	if InputEventMouseMotion:
		
		if cL_graph.pressed:
			cL_graph.rect_global_position=get_global_mouse_position()
			update()
			
		if cD_graph.pressed:
			cD_graph.rect_global_position=get_global_mouse_position()
			update()
	
		if cD_div_cL_graph.pressed:
			cD_div_cL_graph.rect_global_position=get_global_mouse_position()

			update()
			
		if cL_div_cD_graph.pressed:
			cL_div_cD_graph.rect_global_position=get_global_mouse_position()

			update()
			
			
			
		_indicator(indicator_cL,pivot.global_rotation,global_var.cL,cL_graph.rect_global_position,graph_size)
		
		_indicator(indicator_cD,pivot.global_rotation,global_var.cD,cD_graph.rect_global_position,graph_size)
		
		if abs(global_var.cL)>0:
			_indicator(indicator_cD_div_cL,pivot.global_rotation,global_var.cD/global_var.cL,cD_div_cL_graph.rect_global_position,graph_size)
			
		if abs(global_var.cD)>0:
			_indicator(indicator_cL_div_cD,pivot.global_rotation,global_var.cL/global_var.cD,cL_div_cD_graph.rect_global_position,graph_size)







func _draw_bow_shock_line(graph,parent):
	
	var yVal=Vector2()
	if abs(global_var.bow_shock_angle)<10:
		for i in range (11):
			#Vector2(0,graph.rect_global_position.y-global_var.cL_plot_list.back()).linear_interpolate(Vector2(0,graph.rect_global_position.y),float(i)/10)
			
			if graph==cL_graph and global_var.cL_plot_list.back()!=null:
				yVal=Vector2(0,global_var.cL_plot_list.back()).linear_interpolate(Vector2(0,0),float(i)/11)
				
			if graph==cD_graph and global_var.cD_plot_list.back()!=null:
				yVal=Vector2(0,global_var.cD_plot_list.back()).linear_interpolate(Vector2(0,0),float(i)/11)
			
			#print(yVal,graph.rect_global_position)
			#yVal=graph.rect_global_position
			_add_points(deg2rad(global_var.bow_shock_angle),yVal.y,graph.rect_global_position,graph_size,graph,parent)



#func _on_alpha_slider_value_changed(value): #alpha slider chnage
#
#	if show_cL_graph_button.pressed==true:
#		_add_points(global_var.alpha_radians, global_var.cL , cL_graph.rect_global_position , graph_size,cL_graph)
#
#	update()







func _on_gamma_slider_button_button_up():
	global_var.aerofoil_geomtery_changed=true
	_update_graph(false,cL_graph)
	
	_update_graph(false,cD_graph)
	
	_update_graph(false,cD_div_cL_graph)
	
	_update_graph(false,cL_div_cD_graph)
	
	update()
	print(global_var.cL_plot_list)
	
	global_var.aerofoil_geomtery_changed=false
	pass # Replace with function body.





func _on_m_slider_button_button_up():
	global_var.aerofoil_geomtery_changed=true
	_update_graph(false,cL_graph)
	
	_update_graph(false,cD_graph)
	
	_update_graph(false,cD_div_cL_graph)
	
	_update_graph(false,cL_div_cD_graph)
	
	update()
	print(global_var.cL_plot_list)
	global_var.aerofoil_geomtery_changed=false
	pass # Replace with function body.
