#Copyright (c) 2019 Mehdi Msayib#
extends MeshInstance


onready var rot_speed_slider=get_parent().get_node("rot_speed_slider/slider")
onready var rot_speed_label=get_parent().get_node("rot_speed_slider/Label")
onready var aerofoil_blade_scene=preload("res://scenes/aerofoil_blade.tscn")
onready var spotlight=get_parent().get_node("lights/SpotLight")
var blade_count=float(5)
var blade_AoA=20



func _process(delta):
	
	var rot_speed=rot_speed_slider.value
	rotate_z(rot_speed*delta)
	
	rot_speed_label.text='Rotational speed : ' + str(stepify(rot_speed*delta,0.01)) + ' (rad/s)'



func _on_blade_AoA_rotation_value_changed(value):
	var aoa=deg2rad(value)
	
	for i in get_child_count():
		get_child(i).rotate_object_local(Vector3(0,1,0),aoa)
	pass # Replace with function body.




