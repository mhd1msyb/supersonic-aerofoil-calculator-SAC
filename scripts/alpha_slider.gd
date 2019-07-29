#Copyright (c) 2019 Mehdi Msayib#
extends HSlider

func _ready():
	hide()
	get_child(0).text="Angle of Attack : " + str(value)
	pass



func _on_alpha_slider_value_changed(value):
	global_var.alpha_degrees=value
	#global_var.alpha_radians=deg2rad(value)
	get_child(0).text="Angle of Attack : " + str(value)
	pass # replace with function body
