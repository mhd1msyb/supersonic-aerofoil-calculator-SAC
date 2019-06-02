extends HSlider

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var line=get_parent().get_node("Line2D")




#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_HSlider_value_changed(value):
	line.set_width(value)
	global_var.aerofoil_outline_thickness=value
	pass # replace with function body
