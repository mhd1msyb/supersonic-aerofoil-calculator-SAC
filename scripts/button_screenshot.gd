extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var filedialogue=get_node("CanvasLayer/FileDialog")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
