#Copyright (c) 2019 Mehdi Msayib#
extends Spatial


onready var aerofoil_blade_scene=preload("res://scenes/aerofoil_blade.tscn")
onready var hub=get_node("hub")
onready var spotligh=get_node("lights/SpotLight")
var blade_count=float(5)


func _ready():
	
	for i in range(blade_count):
		var blade=aerofoil_blade_scene.instance()
		hub.add_child(blade)
		blade.rotate_z(-float(i)*PI/(blade_count/2))
		blade.rotate_object_local(Vector3(0,1,0),deg2rad(20))
		blade.translate_object_local(Vector3(0,1,0)*4)
	pass # Replace with function body.




func _on_CheckButton_toggled(button_pressed):
	spotligh.shadow_enabled=button_pressed
	pass # Replace with function body.

