extends VBoxContainer
#Copyright Mehdi Msayib#
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var line=get_node("Line2D")
onready var colourPickerButton=get_node("ColorPickerButton")
#onready var main_scene=preload("res://Node.tscn")


func _ready():
	colourPickerButton.color=line.default_color
	pass

func _on_HSlider_value_changed(value):
	line.set_width(value)
	global_var.aerofoil_outline_thickness=value
	pass # replace with function body

func _on_ColorPickerButton_color_changed(color):
	line.default_color=color
	global_var.aerofoil_outline_colour=color
	pass # replace with function body


func _on_back_button_pressed():
	get_tree().change_scene_to(global_var.main_scene)
	
	
	
	pass # replace with function body
