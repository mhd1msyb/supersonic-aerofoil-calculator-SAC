#Copyright (c) 2019 Mehdi Msayib#
extends HSlider



onready var label=get_node("Label")

func _ready():
	global_var.simulation_precision=1/pow(10,value)
	label.text="Iteration Resolution : " +str(global_var.simulation_precision)
	
	hide()
	pass



func _on_simulation_precision_slider_value_changed(value):
	global_var.simulation_precision=1/pow(10,value)
	
	
	if value==max_value:
		label.text="Iteration Resolution : maximum "
	else:
		label.text="Iteration Resolution : " +str(global_var.simulation_precision)
	pass # replace with function body
