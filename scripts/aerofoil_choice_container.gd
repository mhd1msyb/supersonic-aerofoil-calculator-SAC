extends HBoxContainer
#Copyright Mehdi Msayib#
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")
onready var finish_button=get_parent().get_node("pivot").get_node("Line2D_bottom/finish_button")
onready var button_custom_aerofoil=get_node("button_custom_aerofoil")
onready var button_draw_aerofoil=get_node("button_draw_aerofoil")
onready var button_load_aerofoil=get_node("button_load_aerofoil")
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



		



func _ready():
	finish_button.hide()
	
	if global_var._load()[0]==true:
		button_load_aerofoil.show()
	



func _on_button_custom_aerofoil_pressed():
	global_var.aerofoil_choice="custom"
	finish_button.hide()
	button_custom_aerofoil.get_child(0).show()
	#queue_free()
	pass # replace with function body


func _on_button_draw_aerofoil_pressed():
	global_var.aerofoil_choice="draw"
	finish_button.show()
	queue_free()


