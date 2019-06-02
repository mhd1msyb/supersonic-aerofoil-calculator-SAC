extends Node2D

"""
This script highlights lines which have steep gradients (one line at a time)



"""




onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=pivot.get_node("Line2D_bottom")
onready var index=global_var.index_start_line_error
var count=0
var flash_speed=3 # controls the colour flashing speed of the line

func _ready():
	
	pass # Replace with function body.

func _draw():
	count+=0.0166 *(flash_speed)
	var col=Color(abs(sin(count)),abs(cos(count)),0)
	var starting_coord=line2d_bottom.to_global(line2d_bottom.get_point_position(index))
	var ending_coord=line2d_bottom.to_global(line2d_bottom.get_point_position(index+1))
	draw_line(starting_coord,ending_coord,col,15)
	
	
func _input(event): #delete if l_click 
	if event.is_action_pressed("l_click"):
		queue_free()
	
func _process(delta): # colour line flashing
	update()