extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var rich_text=global_var.rich_text
onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=pivot.get_node("Line2D_bottom")
# Called when the node enters the scene tree for the first time.

var line_midpoint=Vector2()

func _ready():
	var line2d_point_count=line2d_bottom.get_point_count()
	
	for i in line2d_bottom.get_point_count()-1:
		
		var r_text=rich_text.instance()
		
		r_text.text=str(i)+"p"
		
		if i<global_var.index_bottom_top_plate:
			line_midpoint=(line2d_bottom.to_global(line2d_bottom.get_point_position(i))+line2d_bottom.to_global(line2d_bottom.get_point_position(i+1)))*0.5
		else:
			line_midpoint=(line2d_bottom.to_global(line2d_bottom.get_point_position(line2d_point_count-i+global_var.index_bottom_top_plate-2))+line2d_bottom.to_global(line2d_bottom.get_point_position(line2d_point_count-i+global_var.index_bottom_top_plate-1)))*0.5
			
		r_text.rect_global_position=line_midpoint
		
		add_child(r_text)
		
	pass # Replace with function body.






func _input(event):
	
	if InputEventMouseMotion:
		var line2d_point_count=line2d_bottom.get_point_count()
		
		for i in get_child_count():
			
			if i<global_var.index_bottom_top_plate:
				line_midpoint=(line2d_bottom.to_global(line2d_bottom.get_point_position(i))+line2d_bottom.to_global(line2d_bottom.get_point_position(i+1)))*0.5
			else:
				line_midpoint=(line2d_bottom.to_global(line2d_bottom.get_point_position(line2d_point_count-i+global_var.index_bottom_top_plate-2))+line2d_bottom.to_global(line2d_bottom.get_point_position(line2d_point_count-i+global_var.index_bottom_top_plate-1)))*0.5
				
			get_child(i).rect_global_position=line_midpoint
			#get_child(i).rect_rotation=-global_var.alpha_degrees
			