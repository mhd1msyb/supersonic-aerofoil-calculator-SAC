extends OptionButton


func _ready():
	
	hide()

func _create_list():
	for i in range (len(global_var.list_weak_shock_angle)):
		add_item(str(0),i)
		
		
		
		
		
func _update_values():
	for i in range (len(global_var.list_weak_shock_angle)):
		set_item_text(i,"Plate"+str(i+1)+" : "+str(stepify(global_var.list_weak_shock_angle[i],0.01)))
	
	
	
		
func _on_values_weak_shock_pressed():
	clear()
	
	_create_list()

	_update_values()




#func _on_alpha_slider_value_changed(value):
#	_update_values()
#	pass # replace with function body

