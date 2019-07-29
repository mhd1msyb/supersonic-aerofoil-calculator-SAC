#Copyright (c) 2019 Mehdi Msayib#
extends Button


onready var filedialogue=get_node("CanvasLayer/FileDialog")




func _on_button_screenshot_pressed():
	filedialogue.show()
	pass # Replace with function body.




func _on_FileDialog_confirmed():
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")

	var path=filedialogue.current_path
	
	var img=get_viewport().get_texture().get_data()
	img.flip_y()
	img.save_png(path+".png")
	
	pass # Replace with function body.
