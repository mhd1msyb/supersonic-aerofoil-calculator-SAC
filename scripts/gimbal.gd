extends Spatial

var val=0.01
var zoom_val=1
onready var camera=get_node("Camera")
onready var button_press_to_rot=get_parent().get_node("button_press_to_rot")


func _ready():
	global_transform.origin.y+=global_var.aerofoil_height*0.5
	
	pass

func _input(event):
	if event is InputEventMouseMotion:
		if button_press_to_rot.pressed:
			rotate_y(-event.relative.x*val)
			rotate_object_local(Vector3(1,0,0),-event.relative.y*val)
		
		
	if event.is_action_pressed("scroll_up"):
		camera.translate_object_local(Vector3(0,0,-1)*zoom_val)

	if event.is_action_pressed("scroll_down"):
		camera.translate_object_local(Vector3(0,0,1)*zoom_val)