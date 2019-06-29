extends HSlider
#Copyright Mehdi Msayib#
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	hide()
	get_child(0).text="Angle of Attack : " + str(value)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_alpha_slider_value_changed(value):
	global_var.alpha_degrees=value
	#global_var.alpha_radians=deg2rad(value)
	get_child(0).text="Angle of Attack : " + str(value)
	pass # replace with function body
