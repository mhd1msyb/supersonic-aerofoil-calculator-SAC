
extends Button
#Copyright Mehdi Msayib#

onready var line2d_bottom=get_parent().get_node("pivot").get_node("Line2D_bottom")
onready var pivot=get_parent().get_node("pivot")
onready var preload_collision_poly=preload("res://scenes/collision_line.tscn")
onready var raycas=preload("res://scenes/RayCast2D.tscn")




func _on_button_add_node_toggled(button_pressed):
	if button_pressed==true:
		
		####add raycast as a child####
		get_parent().add_child(raycas.instance())
		
		
	if button_pressed==false:
		####delete raycast once you exit edit mode####
		get_parent().get_node("RayCast2D").queue_free()


