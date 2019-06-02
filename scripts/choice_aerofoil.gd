extends OptionButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#for i in range (1):
	add_item("Draw",0)
	add_item("Wedge",1)
	pass



func _on_choice_aerofoil_item_selected(ID):
	#global_var.aerofoil_choice=ID
	pass # replace with function body


func _on_choice_aerofoil_mouse_entered():
	pass
	#global_var.aerofoil_button_hover=true
	



func _on_choice_aerofoil_mouse_exited():
	pass
	#global_var.aerofoil_button_hover=false
