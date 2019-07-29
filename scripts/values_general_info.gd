#Copyright (c) 2019 Mehdi Msayib#
extends OptionButton

onready var line2d_bottom=get_parent().get_node("pivot").get_node("Line2D_bottom")

onready var list_vars=[global_var.t_c,global_var.t,global_var.c,line2d_bottom.get_point_count()]
var list_names=["T/C= ","Thickness (px)= ","Chord Length (px)= ","Total number of nodes= "]

func _ready():
	hide()



func _create_list():
	
	
	for i in range (len(list_vars)):
		add_item(str(0),i)
		
		
		
		
		
func _update_values():
	
	list_vars=[global_var.t_c,global_var.t,global_var.c,line2d_bottom.get_point_count()]
	
	for i in range (len(list_names)):
		set_item_text( i,list_names[i]+str(stepify(list_vars[i],0.01)) )
	
	
	


func _on_values_general_info_pressed():
	clear()
	
	_create_list()

	_update_values()