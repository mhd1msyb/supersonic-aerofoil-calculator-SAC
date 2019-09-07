#Copyright (c) 2019 Mehdi Msayib#
extends Polygon2D

"""
this polygon is used to hide unnecessary buttons at the start screen

"""
onready var button_custom_aerofoil=get_parent().get_node("aerofoil_choice_container/HBoxContainer/button_custom_aerofoil/aerofoil_library_popup")
onready var button_draw_aerofoil=get_parent().get_node("aerofoil_choice_container/HBoxContainer/button_draw_aerofoil")
onready var button_load_aerofoil=get_parent().get_node("aerofoil_choice_container/HBoxContainer/button_load_aerofoil")


func _ready():
	show()
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if  button_draw_aerofoil.pressed or button_load_aerofoil.pressed:
			queue_free()
	
	if event is InputEventScreenTouch:
		if button_draw_aerofoil.pressed or button_load_aerofoil.pressed:
			queue_free()