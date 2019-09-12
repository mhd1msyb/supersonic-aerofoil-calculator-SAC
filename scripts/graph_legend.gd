extends PanelContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var legend_colour_code_sc=preload("res://scenes/legend_color_code.tscn")
onready var vbox=get_node("VBoxContainer/PanelContainer/ScrollContainer/VBoxContainer")
onready var scroll_container=get_node("VBoxContainer/PanelContainer/ScrollContainer")
onready var button_drag=get_node("VBoxContainer/button_drag")
onready var button_resize=get_node("VBoxContainer/button_resize")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if visible==true:
		if event is InputEventMouseMotion:
			if button_drag.pressed:
				rect_global_position+=event.relative
			if button_resize.pressed:
				rect_size+=event.relative
	else:
		return


func _on_m_slider_button_button_up():
	var legend_colour_code=legend_colour_code_sc.instance()
	vbox.add_child(legend_colour_code)
	legend_colour_code.get_node("TextureRect").material.set_shader_param("random_graph_point_color",Vector3(global_var.random_graph_point_color.r,global_var.random_graph_point_color.g,global_var.random_graph_point_color.b))
	legend_colour_code.get_node("Label").text="Flow Spd : "+str(global_var.m1) + """
	, Gamma : """ + str(global_var.gamma) 
	
	scroll_container.scroll_vertical=legend_colour_code.get_child_count()*vbox.rect_size.y
	
	pass # Replace with function body.
