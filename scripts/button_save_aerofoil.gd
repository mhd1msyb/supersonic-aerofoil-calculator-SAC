
extends Button
#Copyright Mehdi Msayib#

onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")
onready var alpha_slider=get_parent().get_node("alpha_slider")
onready var label_with_timer=preload("res://scenes/label_with_timer.tscn")
onready var prox=preload("res://scenes/proxy_expansion_fan.tscn")
onready var save_dialogue=get_node("PanelContainer")
onready var save_dialogue_textedit=get_node("PanelContainer/VBoxContainer/TextEdit")


func _ready():
	
	hide()




func _save():
	
	var dir=Directory.new()
	var new_file=File.new()
	
	var line_coord=[]
	print(OS.get_user_data_dir())
	if dir.dir_exists(OS.get_user_data_dir()+"/saved_data_folder"):
		new_file.open(OS.get_user_data_dir()+"/saved_data_folder/"+save_dialogue_textedit.text+".sac",File.WRITE)
		for i in range(line2d_bottom.get_point_count()):
			line_coord.append([line2d_bottom.get_point_position(i).x,line2d_bottom.get_point_position(i).y])
		new_file.store_var(line_coord)
		
		
	else:
		dir.make_dir(OS.get_user_data_dir()+"/saved_data_folder")
		new_file.open(OS.get_user_data_dir()+"/saved_data_folder/"+save_dialogue_textedit.text+".sac",File.WRITE)
		for i in range(line2d_bottom.get_point_count()):
			line_coord.append([line2d_bottom.get_point_position(i).x,line2d_bottom.get_point_position(i).y])
		new_file.store_var(line_coord)











func _on_button_save_aerofoil_pressed():
	save_dialogue.show()
	pass # replace with function body


func _on_Button_pressed():
	
	#for i in (save_dialogue.get_node("VBoxContainer/TextEdit").text):
	
	var label_with_timer_instance=label_with_timer.instance() 
	add_child(label_with_timer_instance)
	label_with_timer_instance.rect_global_position=rect_global_position+Vector2(15,50)
	
	pivot.global_rotation=0 # rotate to initial
	
	global_var.save_aerofoil=true
	
	_save()
	
	pivot.global_rotation=deg2rad(alpha_slider.value) # rotate back
	
	label_with_timer_instance.text="Saved!"
	pass # Replace with function body.


