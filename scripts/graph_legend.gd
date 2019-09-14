extends PanelContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var legend_colour_code_sc=preload("res://scenes/legend_color_code.tscn")
onready var vbox=get_node("VBoxContainer/PanelContainer/ScrollContainer/VBoxContainer")
onready var scroll_container=get_node("VBoxContainer/PanelContainer/ScrollContainer")
onready var button_drag=get_node("VBoxContainer/HBoxContainer/button_drag")
onready var button_resize=get_node("VBoxContainer/button_resize")

onready var cL_graph=get_parent().get_node("graphs_cL_cD/cL_graph")
onready var cD_graph=get_parent().get_node("graphs_cL_cD/cD_graph")
onready var cL_div_cD_graph=get_parent().get_node("graphs_cL_cD/cL_div_cD_graph")
onready var cD_div_cL_graph=get_parent().get_node("graphs_cL_cD/cD_div_cL_graph")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.

func _input(event):
	if visible==true:
		if event is InputEventMouseMotion:
			if button_drag.pressed:
				rect_global_position+=event.relative
			if button_resize.pressed:
				rect_size+=event.relative
				
#		if event is InputEventMouseButton:
#			if cL_graph.toggle_mode==true or cD_graph.toggle_mode==true or cD_div_cL_graph.toggle_mode==true or cL_div_cD_graph.toggle_mode==true:
#				show()
	else:
		return


func _on_m_slider_button_button_up():
	var legend_colour_code=legend_colour_code_sc.instance()
	vbox.add_child(legend_colour_code)
	legend_colour_code.get_node("TextureRect").material.set_shader_param("random_graph_point_color",global_var.random_graph_point_color)
	legend_colour_code.get_node("Label").text="Flow Spd : "+str(global_var.m1) + """
	, Gamma : """ + str(global_var.gamma) 
	
	scroll_container.scroll_vertical=legend_colour_code.get_child_count()*vbox.rect_size.y
	
	pass # Replace with function body.


func _on_gamma_slider_button_button_up():
	var legend_colour_code=legend_colour_code_sc.instance()
	vbox.add_child(legend_colour_code)
	legend_colour_code.get_node("TextureRect").material.set_shader_param("random_graph_point_color",global_var.random_graph_point_color)
	legend_colour_code.get_node("Label").text="Flow Spd : "+str(global_var.m1) + """
	, Gamma : """ + str(global_var.gamma) 
	
	scroll_container.scroll_vertical=legend_colour_code.get_child_count()*vbox.rect_size.y
	pass # Replace with function body.




func _on_finish_button_pressed():
	var legend_colour_code=legend_colour_code_sc.instance()
	vbox.add_child(legend_colour_code)
	legend_colour_code.get_node("TextureRect").material.set_shader_param("random_graph_point_color",global_var.random_graph_point_color)
	legend_colour_code.get_node("Label").text="Flow Spd : "+str(global_var.m1) + """
	, Gamma : """ + str(global_var.gamma) 
	
	scroll_container.scroll_vertical=legend_colour_code.get_child_count()*vbox.rect_size.y
	pass # Replace with function body.




func _on_aerofoil_library_popup_index_pressed(index):
	var legend_colour_code=legend_colour_code_sc.instance()
	vbox.add_child(legend_colour_code)
	legend_colour_code.get_node("TextureRect").material.set_shader_param("random_graph_point_color",global_var.random_graph_point_color)
	legend_colour_code.get_node("Label").text="Flow Spd : "+str(global_var.m1) + """
	, Gamma : """ + str(global_var.gamma) 
	
	scroll_container.scroll_vertical=legend_colour_code.get_child_count()*vbox.rect_size.y
	pass # Replace with function body.



func _on_open_aerofoil_button_pressed():
	var legend_colour_code=legend_colour_code_sc.instance()
	vbox.add_child(legend_colour_code)
	legend_colour_code.get_node("TextureRect").material.set_shader_param("random_graph_point_color",global_var.random_graph_point_color)
	legend_colour_code.get_node("Label").text="Flow Spd : "+str(global_var.m1) + """
	, Gamma : """ + str(global_var.gamma) 
	
	scroll_container.scroll_vertical=legend_colour_code.get_child_count()*vbox.rect_size.y
	pass # Replace with function body.




func _on_button_hide_pressed():
	hide()
	pass # Replace with function body.


func _on_button_clear_pressed():
	for i in vbox.get_children():
		i.queue_free()
	pass # Replace with function body.









