extends Button
#Copyright Mehdi Msayib#
# class member variables go here, for example:
# var a = 2

onready var aerofoil3D_scene=preload("res://scenes/3d_aerofoil_scene.tscn")

onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")


func _ready():
	disabled=true


func _on_button_3d_mesh_pressed():
	
	global_var.aerofoil_3d_mesh_coords.clear()
	for i in range(line2d_bottom.get_point_count()):
		var line2d_point_coords=line2d_bottom.to_global(line2d_bottom.get_point_position(i))
		var mesh_3d_coord=Vector3(line2d_point_coords.x,0,line2d_point_coords.y)
		global_var.aerofoil_3d_mesh_coords.append(mesh_3d_coord)
	
	
	get_tree().change_scene_to(aerofoil3D_scene)
	pass # replace with function body
