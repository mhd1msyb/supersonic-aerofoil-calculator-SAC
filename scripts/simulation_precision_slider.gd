extends HSlider

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var label=get_node("Label")

func _ready():
	global_var.simulation_precision=1/pow(10,value)
	label.text="Iteration Resolution : " +str(global_var.simulation_precision)
	
	hide()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_simulation_precision_slider_value_changed(value):
	global_var.simulation_precision=1/pow(10,value)
	
	
	if value==max_value:
		label.text="Iteration Resolution : maximum "
	else:
		label.text="Iteration Resolution : " +str(global_var.simulation_precision)
	pass # replace with function body
