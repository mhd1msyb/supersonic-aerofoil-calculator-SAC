#Copyright (c) 2019 Mehdi Msayib#
extends HSlider



func _ready():
	global_var.m1=value
	get_child(0).text="Inlet flow speed: " + str(value)
	hide()
	pass



func _on_m_slider_value_changed(value):
	global_var.m1=value	
	get_child(0).text="Inlet flow speed: " + str(value)
	pass # replace with function body
