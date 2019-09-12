extends Spatial

onready var rot_speed_slider=get_node("rot_speed_slider/slider")
onready var rot_speed_label=get_node("rot_speed_slider/Label")
onready var aerofoil_blade_scene=preload("res://scenes/aerofoil_blade.tscn")
onready var spotlight=get_node("lights/SpotLight")
onready var hub=get_node("hub")
onready var single_blade_parent=get_node("single_blade_parent")
var blade_count=float(5)
var blade_AoA=20
# Called when the node enters the scene tree for the first time.
func _ready():

	for i in range(blade_count): # instantiate blades and add them to the hub in a cicular arrangement
		var turbine_blade=aerofoil_blade_scene.instance()
		hub.add_child(turbine_blade)
		turbine_blade.rotate_z(-float(i)*PI/(blade_count/2))
		turbine_blade.rotate_object_local(Vector3(0,1,0),deg2rad(20))
		turbine_blade.translate_object_local(Vector3(0,1,0)*4)
		
		
	var single_blade=aerofoil_blade_scene.instance()
	single_blade_parent.add_child(single_blade)
		
	single_blade_parent.hide()
	pass # Replace with function body.



func _on_OptionButton_item_selected(ID):
	if ID==0:
		hub.show()
		single_blade_parent.hide()
	if ID==1:
		hub.hide()
		single_blade_parent.show()
	pass # Replace with function body.


func _on_shadow_checkbox_toggled(button_pressed):
	spotlight.shadow_enabled=button_pressed
	pass # Replace with function body.


func _on_wireframe_checkbox_toggled(button_pressed):
	for i in hub.get_children():
		i.get_node("wireframe").visible=button_pressed
	single_blade_parent.get_child(0).get_node("wireframe").visible=button_pressed
	pass # Replace with function body.


func _on_solid_checkbox_toggled(button_pressed):
	for i in hub.get_children():
		i.get_node("aerofoil_mesh").visible=button_pressed
	single_blade_parent.get_child(0).get_node("aerofoil_mesh").visible=button_pressed
	pass # Replace with function body.
