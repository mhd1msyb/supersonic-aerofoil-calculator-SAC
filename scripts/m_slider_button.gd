#Copyright (c) 2019 Mehdi Msayib#
extends TextureButton


onready var knob_sprite=get_node("knob_sprite")
onready var label=get_node("Label")

onready var button_size=rect_size
onready var button_global_pos=rect_global_position
export var precision_step=0.1
export var starting_value=float(2)
export var min_slider_value=float(1)
export var max_slider_value=float(3)

# Called when the node enters the scene tree for the first time.
func _ready():
	knob_sprite.global_transform.origin.x=(Vector2(button_global_pos.x,0).linear_interpolate(Vector2(button_global_pos.x+button_size.x,0),(starting_value-min_slider_value)/(max_slider_value-min_slider_value))).x
	knob_sprite.global_transform.origin.y=button_global_pos.y+button_size.y*0.5
	global_var.m1=starting_value
	label.text="Flow speed : "+str(starting_value)
	hide()
	
	
func _input(event):
	
	var x_position=clamp(get_global_mouse_position().x,button_global_pos.x,button_global_pos.x+button_size.x)
	var value=stepify((Vector2(min_slider_value,0).linear_interpolate(Vector2(max_slider_value,0),(x_position-button_global_pos.x)/button_size.x)).x,precision_step)
	
	if pressed:
		knob_sprite.global_transform.origin.x=x_position
		global_var.m1=value
		label.text="Flow speed : "+str(value)
		#print(value)
	pass
	
	


func _on_m_slider_button_button_up():
	pass # Replace with function body.
