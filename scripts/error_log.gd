extends PanelContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var message_box=get_node("VBoxContainer/background/ScrollContainer/message_box")
onready var button_hide=get_node("VBoxContainer/VBoxContainer/button_hide")
onready var button_drag=get_node("VBoxContainer/VBoxContainer/button_drag")
onready var button_clear=get_node("VBoxContainer/VBoxContainer/button_clear")
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if visible==true:
		if event is InputEventMouseMotion:
			if button_drag.pressed:
				rect_global_position+=event.relative
	else:
		return



func _on_button_clear_log_pressed():
	for i in message_box.get_children():
		i.queue_free()
	pass # Replace with function body.


func _on_button_hide_pressed():
	hide()
	pass # Replace with function body.
