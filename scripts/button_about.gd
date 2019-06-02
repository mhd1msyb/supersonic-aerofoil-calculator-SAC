extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var about_scene=preload("res://scenes/about_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_about_pressed():
	global_var._refresh_lists()
	get_tree().change_scene_to(about_scene)
	pass # Replace with function body.
