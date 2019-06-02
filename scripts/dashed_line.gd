extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var viewport_vec=global_var.viewport_vec*0.5

func _ready():
	update()
	pass

func _draw():

		
	#DRAW DASHED NEUTRAL LINE##################
	var a=[]
	var num_dashes=500
	for i in range (num_dashes):
		a.append(viewport_vec+Vector2(i-num_dashes,0)*10)
	for i in range (num_dashes):
		a.append(viewport_vec+Vector2(num_dashes-i,0)*10)


	draw_multiline(a,Color(0.1,0.9,0.05),5)