extends Node2D

onready var pivot=get_parent().get_node("pivot")
onready var line2d_bottom=get_parent().get_node("pivot/Line2D_bottom")
onready var label=get_node("label_angle")

var arc_resolution=50
const arc_radius=450
const line_length=200
#func _ready():
#	global_transform.origin=pivot.global_transform.origin


func _draw():
#	var point_array=[]
#
#	for i in (arc_resolution+1):
#		var theta=(float(i)/float(arc_resolution))*pivot.global_rotation
#		var xy_vector=Vector2(-cos(theta),-sin(theta))*size
#		point_array.append(xy_vector)
#
#	draw_polyline(point_array,ColorN("springgreen",0.6),8)
	
	if line2d_bottom.get_point_count()>0:
		
		####draw line####
		var dir_vec=(line2d_bottom.to_global(line2d_bottom.get_point_position(0))-pivot.global_position).normalized()
		var line_start=line2d_bottom.to_global(line2d_bottom.get_point_position(0))
		var line_end=line2d_bottom.to_global(line2d_bottom.get_point_position(0))+(dir_vec*line_length)
		draw_line(line_start,line_end,ColorN("mediumturquoise",0.5),2)
		
		####draw arc####
		var point_array=[]
		for i in (arc_resolution+1):
			var theta=(float(i)/float(arc_resolution))*pivot.global_rotation
			var xy_vector=Vector2(-cos(theta),-sin(theta))*arc_radius + pivot.global_position
			point_array.append(xy_vector)
		draw_polyline(point_array,ColorN("springgreen",0.6),8)
		
		
		
		####update text position + chars####
		
		label.rect_global_position=Vector2(line_start.x,(pivot.global_position.y+line_end.y)*0.5) # set position
		label.text=str(stepify(pivot.global_rotation_degrees,0.1)) + " deg" # set text
		
		



func _on_alpha_slider_value_changed(value):
	if visible==true:
		update()
	pass # Replace with function body.
