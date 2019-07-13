
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


func _on_button_save_aerofoil_pressed():
	save_dialogue.show()
	pass # replace with function body



func _save():
	
	var dir=Directory.new()
	var new_file=File.new()
	
	var data={ "coords":[], "file name":["user defined","actual hash name"]}
	
	if dir.dir_exists(OS.get_user_data_dir()+"/saved_data_folder")==false: # if a save folder doesnt exists, then create one
		dir.make_dir(OS.get_user_data_dir()+"/saved_data_folder")
		
	
	
	var user_defined_name=save_dialogue_textedit.text # this is what the user types in
	var actual_file_hash_name="s"+str(save_dialogue_textedit.text.hash()) # this is the name of the file on disk 
	
	new_file.open(OS.get_user_data_dir()+"/saved_data_folder/"+actual_file_hash_name+".sac",File.WRITE)
	
	for i in range(line2d_bottom.get_point_count()):
		data["coords"].append([line2d_bottom.get_point_position(i).x,line2d_bottom.get_point_position(i).y])
		
	
	data["file name"]=[user_defined_name,actual_file_hash_name]
	
	new_file.store_var(data)
	
	
	
	var label_with_timer_instance=label_with_timer.instance() 
	add_child(label_with_timer_instance)
	label_with_timer_instance.rect_global_position=save_dialogue.rect_global_position
	label_with_timer_instance.text="Saved!"
	
	
	return





func _on_close_button_pressed():
	save_dialogue.hide()
	pass # Replace with function body.


func _on_save_button_pressed():

	
	pivot.global_rotation=0 # rotate to initial
	
	global_var.save_aerofoil=true
	
	_save()
	
	pivot.global_rotation=deg2rad(alpha_slider.value) # rotate back
	

	return