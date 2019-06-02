extends MeshInstance

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var rot_speed_slider=get_parent().get_node("rot_speed_slider").get_node("slider")
onready var aerofoil_blade_scene=preload("res://scenes/aerofoil_blade.tscn")
onready var spotlight=get_parent().get_node("lights/SpotLight")
var blade_count=float(5)
var blade_AoA=20
# Called when the node enters the scene tree for the first time.
func _ready():

	
	for i in range(blade_count): # instantiate blades and add them to the hub in a cicular arrangement
		var blade=aerofoil_blade_scene.instance()
		add_child(blade)
		blade.rotate_z(-float(i)*PI/(blade_count/2))
		blade.rotate_object_local(Vector3(0,1,0),deg2rad(20))
		blade.translate_object_local(Vector3(0,1,0)*4)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var rot_speed=rot_speed_slider.value
	rotate_z(rot_speed*delta)
	



func _on_blade_AoA_rotation_value_changed(value):
	var aoa=deg2rad(value)
	
	for i in get_child_count():
		get_child(i).rotate_object_local(Vector3(0,1,0),aoa)
	pass # Replace with function body.


func _on_CheckButton_toggled(button_pressed):
	spotlight.shadow_enabled=button_pressed
	pass # Replace with function body.
