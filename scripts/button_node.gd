#Copyright (c) 2019 Mehdi Msayib#
extends Button



#func _input(event):
#	if pressed and global_var.edit_mode==true:
#		rect_global_position=get_global_mouse_position()-Vector2(rect_size.x/2,rect_size.y/2)
		

func _ready():
	#get_child(1).hide()
	
	set_pivot_offset(rect_size*0.5)
	#print(rect_size)
	
	for i in range(get_child_count()):
		get_child(i).global_transform.origin=rect_global_position+rect_size*0.5
	


func _on_Button_mouse_entered():
	get_child(1).show()
	pass # replace with function body


func _on_Button_mouse_exited():
	get_child(1).hide()
	pass # replace with function body


