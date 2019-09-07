#Copyright (c) 2019 Mehdi Msayib#
extends VBoxContainer


onready var error_large_deflection_angle=get_node("error_large_deflection_angle")
onready var error_exceeded_dataset=get_node("error_exceeded_dataset")


func _on_alpha_slider_value_changed(value):

	if global_var.error_large_def_angle_ob_shock_func==true or global_var.error_large_def_angle==true:
		error_large_deflection_angle.show()
	else:
		error_large_deflection_angle.hide()
		
		
		
	if global_var.error_exceeded_dataset_1==true or global_var.error_exceeded_dataset_2==true or global_var.error_exceeded_dataset_3==true or global_var.error_exceeded_dataset_4==true:
		error_exceeded_dataset.show()
	else:
		error_exceeded_dataset.hide()