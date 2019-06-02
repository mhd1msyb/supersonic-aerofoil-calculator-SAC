
extends Button
#Copyright Mehdi Msayib#

onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")
onready var alpha_slider=get_parent().get_node("alpha_slider")
onready var label_with_timer=preload("res://scenes/label_with_timer.tscn")
onready var prox=preload("res://scenes/proxy_expansion_fan.tscn")

func _ready():
	
	hide()




func _save():
	var new_file=File.new()
	new_file.open("user://saveddata.save",File.WRITE)
	var point_count=global_var.saved_aerofoil_point_count
	
	var dict={
		
	}
	
	
	if global_var.save_aerofoil==true:
		dict["point count"]=point_count
		for i in range(point_count):
			dict[str(i)+"x"]=global_var.saved_aerofoil_coords[i].x
	
		for i in range(point_count):
			dict[str(i)+"y"]=global_var.saved_aerofoil_coords[i].y
				
		new_file.store_line(to_json(dict))
	
	
	print(dict)
















func _on_button_save_aerofoil_pressed():
	
	var label_with_timer_instance=label_with_timer.instance() 
	add_child(label_with_timer_instance)
	label_with_timer_instance.rect_global_position=rect_global_position+Vector2(15,50)
	
	pivot.global_rotation=0 # rotate to initial
	
	global_var.save_aerofoil=true
	
	for i in range(line2d_bottom.get_point_count()):
		global_var.saved_aerofoil_coords.append(line2d_bottom.get_point_position(i))
	
	
	global_var.saved_aerofoil_point_count=line2d_bottom.get_point_count()
	
	_save()
	
	pivot.global_rotation=deg2rad(alpha_slider.value) # rotate back
	
	label_with_timer_instance.text="Saved!"
		
		
	pass # replace with function body
