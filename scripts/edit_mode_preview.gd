extends HBoxContainer

"""

0-add
1-del
2-move
3-chord
4-thick

"""
onready var label=get_node("Label")
onready var texturerect=get_node("TextureRect")

onready var about_icon_texture=load("res://textures/about_icon.png")
onready var add_icon_texture=load("res://textures/add_node_icon.png")
onready var delete_node_texture=load("res://textures/delete_node_icon.png")
onready var move_node_texture=load("res://textures/move_node_icon.png")
onready var chord_texture=load("res://textures/chord_icon.png")
onready var thickness_texture=load("res://textures/thickness_icon.png")

onready var texture_array=[add_icon_texture,delete_node_texture,move_node_texture,chord_texture,thickness_texture]
onready var name_array=["ADD","DELETE","MOVE","CHORD","THICKNESS"]



func _ready():
	hide()
	pass # Replace with function body.



func _on_PopupMenu_index_pressed(index):

	
	texturerect.texture=texture_array[index]
	label.text="EDIT : " + name_array[index]
	
	pass # Replace with function body.


func _on_button_edit_toggled(button_pressed):
	visible=button_pressed
	#rect_global_position.x=OS.window_size.x-rect_size.x*1.5
	if button_pressed==true:
		texturerect.texture=null
		label.text="EDIT : NULL "
		
	pass # Replace with function body.
