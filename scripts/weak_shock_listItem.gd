#Copyright (c) 2019 Mehdi Msayib#
extends ItemList




func _ready():
	get_parent().hide()
	pass # Replace with function body.



func _on_alpha_slider_value_changed(value):
	if get_parent().visible==true:
		clear()
		for i in len(global_var.list_weak_shock_angle):
			add_item("Plate"+str(i)+" : "+str(stepify(global_var.list_weak_shock_angle[i],0.01)),null,false)
			
		add_item("Top trail edge"+" : "+str(stepify(global_var.weak_shock_END_EDGE_TOP,0.01)),null,false)# for top trailing edge weak shock
		add_item("Bottom trail edge"+" : "+str(stepify(global_var.weak_shock_END_EDGE_BOTTOM,0.01)),null,false)# for top trailing edge weak shock
