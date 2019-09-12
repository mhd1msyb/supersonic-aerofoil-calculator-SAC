#Copyright (c) 2019 Mehdi Msayib#
extends Button

"""

0- weak shock angles
1 - strong shock angles
2- aerofoil geomtery stats
3- simulation precision
4- arrow inlet flow (hide/show)
5- show/hide green dashed neutral line
- show/hide plate indices
6- show bow shock data (i.e. AoA at which it occurs)
7 - flow speeds 
8 - pressure ratios p/p1 
9 - plate indices 
10 - node indices 
11 - aerofoil aoa 
12 - screenshot
13 - fps counter
14 - error log
15 - graph legend

"""

onready var rich_text_scene=preload("res://scenes/rich_text.tscn")


onready var popup=get_node("CanvasLayer/PopupMenu")
#onready var weak_shock_angle_list=get_parent().get_node("values_weak_shock")
onready var data_tables=get_parent().get_node("data_tables")
onready var weak_shock_listItem=get_parent().get_node("data_tables/VBoxContainer/weak_shock_listItem")
onready var strong_shock_listItem=get_parent().get_node("data_tables/VBoxContainer/strong_shock_listItem")
onready var aerofoil_geometry_stats=get_parent().get_node("aerofoil_geometry_stats")
onready var simulation_precision_slider=get_parent().get_node("simulation_precision_slider")
onready var arrow_inlet_flow=get_parent().get_node("arrow_inlet_flow")
onready var dashed_line=get_parent().get_node("dashed_line")
onready var bow_shock_data_listItem=get_parent().get_node("data_tables/VBoxContainer/bow_shock_data_listItem")
onready var flow_speeds_listItem=get_parent().get_node("data_tables/VBoxContainer/flow_speeds_listItem")
onready var p_p1_listItem=get_parent().get_node("data_tables/VBoxContainer/p_p1_listItem")
onready var plate_indices_scene=global_var.plate_indices_scene
onready var node_indices_scene=global_var.node_indices_scene
onready var aoa_circular_arc=get_parent().get_node("AoA_circular_arc")
onready var button_screenshot=get_parent().get_node("button_screenshot")
onready var fps=get_parent().get_node("FPS")
onready var error_log=get_parent().get_node("error_log")
onready var graph_legend=get_parent().get_node("graph_legend")



func _ready():
	disabled=true
	bow_shock_data_listItem.hide()
	data_tables.hide()


func _on_PopupMenu_index_pressed(index):
	
	if index==0 and weak_shock_listItem.visible==false: #weak shock
		weak_shock_listItem.visible=true
	elif index==0 and weak_shock_listItem.visible==true:
		weak_shock_listItem.hide()
		
		
		
		
	if index==1 and strong_shock_listItem.visible==false:#strong shock
		strong_shock_listItem.visible=true
	elif index==1 and strong_shock_listItem.visible==true:
		strong_shock_listItem.visible=false
		
		
		
	if index==2 and aerofoil_geometry_stats.visible==false:#aerofoil geom info
		aerofoil_geometry_stats.visible=true
	elif index==2 and aerofoil_geometry_stats.visible==true:
		aerofoil_geometry_stats.visible=false
		
		
		
		
		
	if index==3 and simulation_precision_slider.visible==false:#simulation precision
		simulation_precision_slider.visible=true
	elif index==3 and simulation_precision_slider.visible==true:
		simulation_precision_slider.visible=false
		
		
	if index==4 and arrow_inlet_flow.visible==false:#inlet flow arrow
		arrow_inlet_flow.visible=true
	elif index==4 and arrow_inlet_flow.visible==true:
		arrow_inlet_flow.visible=false
		
		
		
	if index==5 and dashed_line.visible==false:#dashed line
		dashed_line.visible=true
	elif index==5 and dashed_line.visible==true:
		dashed_line.visible=false
		
		
		
	if index==6 and bow_shock_data_listItem.visible==false:#bow shock data
		bow_shock_data_listItem.visible=true
		
		var itlist=bow_shock_data_listItem.get_node("ItemList")
		if abs(global_var.bow_shock_angle)<10:
			itlist.clear()
			itlist.add_item("AoA : "+ str(global_var.bow_shock_angle) + " (deg)", null, true)
			itlist.add_item("cL : "+ str(global_var.cL_plot_list.back()), null, true)
			itlist.add_item("cD : "+ str(global_var.cD_plot_list.back()), null, true)
			itlist.add_item("cD/cL : "+ str(global_var.cD_div_cL_plot_list.back()), null, true)
		else:
			itlist.clear()
			itlist.add_item("No bow shock occurs for", null, true)
			itlist.add_item("the current flow", null, true)
			itlist.add_item("conditions below", null, true)
			itlist.add_item("an AoA of 10.", null, true)
			
	elif index==6 and bow_shock_data_listItem.visible==true:
		bow_shock_data_listItem.visible=false
		
		
	if index==7 and flow_speeds_listItem.visible==false:#flow speeds
		flow_speeds_listItem.visible=true
	elif index==7 and flow_speeds_listItem.visible==true:
		flow_speeds_listItem.visible=false
		
		
		
		
	if index==8 and p_p1_listItem.visible==false:#p/p1 data
		p_p1_listItem.visible=true
	elif index==8 and p_p1_listItem.visible==true:
		p_p1_listItem.visible=false

	
	
	
	if index==9 and get_parent().get_node_or_null("plate_indices")==null:
		get_parent().add_child(plate_indices_scene.instance())
	elif index==9 and get_parent().get_node_or_null("plate_indices")!=null:
		get_parent().get_node("plate_indices").queue_free()
		
		
		
	if index==10 and get_parent().get_node_or_null("node_indices")==null:
		get_parent().add_child(node_indices_scene.instance())
	elif index==10 and get_parent().get_node_or_null("node_indices")!=null:
		get_parent().get_node("node_indices").queue_free()
	
	
	if index==11 and aoa_circular_arc.visible==false:#circular arc
		aoa_circular_arc.visible=true
	elif index==11 and aoa_circular_arc.visible==true:
		aoa_circular_arc.visible=false
	
	
	
	if index==12 and button_screenshot.visible==false:#screenshot button
		button_screenshot.visible=true
	elif index==12 and button_screenshot.visible==true:
		button_screenshot.visible=false
	
	
	if index==13 and fps.visible==false:#fps indicator
		fps.visible=true
	elif index==13 and fps.visible==true:
		fps.visible=false



	if index==14 and error_log.visible==false:#error log
		error_log.visible=true
	elif index==14 and error_log.visible==true:
		error_log.visible=false
		
		
	if index==15 and graph_legend.visible==false:#error log
		graph_legend.visible=true
	elif index==15 and graph_legend.visible==true:
		graph_legend.visible=false
		
		
	if weak_shock_listItem.visible==false and strong_shock_listItem.visible==false and p_p1_listItem.visible==false and flow_speeds_listItem.visible==false:
		data_tables.visible=false
	else:
		data_tables.visible=true
		
		
	global_var.button_advanced_popup_index=index
		
	pass # replace with function body



func _on_button_advanced_pressed():
	if popup.visible==false:
		popup.visible=true
	else:
		popup.visible=false
	pass # replace with function body