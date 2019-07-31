#Copyright (c) 2019 Mehdi Msayib#
extends Button


onready var load_aerofoil_dialogue=get_node("PanelContainer")
onready var load_aerofoil_listItem=get_node("PanelContainer/VBoxContainer/ItemList")
# Called when the node enters the scene tree for the first time.
func _ready():
	var dir=Directory.new()
	if dir.dir_exists("user://saved_data_folder"):
		show()
	else:
		hide()


func _on_button_load_aerofoil_pressed():
	
	load_aerofoil_listItem.clear()
	
	load_aerofoil_dialogue.show()
	
	var dir=Directory.new()
	var new_file=File.new()
	
	
	if dir.dir_exists(OS.get_user_data_dir()+"/saved_data_folder"):
		dir.open(OS.get_user_data_dir()+"/saved_data_folder")
		dir.list_dir_begin(true,true)
		var file_get_next=dir.get_next()
		
		
		
		while file_get_next.ends_with(".sac"):
			global_var.saved_files_array.append(file_get_next)
			new_file.open(OS.get_user_data_dir()+"/saved_data_folder/"+file_get_next,File.READ)
			load_aerofoil_listItem.add_item(new_file.get_var()["file name"][0],null,true)
			file_get_next=dir.get_next()
			

#	else:
#		print("there are no files to load (saved data folder not found...)")
#		hide()



func _on_ItemList_item_selected(index):
	global_var.saved_file_index_selected=index
	pass # Replace with function body.


func _on_delete_aerofoil_button_pressed():
	var dir=Directory.new()
	dir.remove(OS.get_user_data_dir()+"/saved_data_folder/"+global_var.saved_files_array[global_var.saved_file_index_selected])
	load_aerofoil_listItem.remove_item(global_var.saved_file_index_selected)
	global_var.saved_files_array.erase(global_var.saved_files_array[global_var.saved_file_index_selected])
	global_var.saved_file_index_selected=0
	
	pass # Replace with function body.


func _on_close_button_pressed():
	load_aerofoil_dialogue.hide()
	pass # Replace with function body.
