extends HBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var graphs_cL_cD=get_parent().get_node("graphs_cL_cD")
onready var button_screenshot=get_parent().get_node("button_screenshot")
onready var m_slider=get_parent().get_node("m_slider_button")
onready var gamma_slider=get_parent().get_node("gamma_slider_button")

var nodes_visibility_status=[]
var node_array=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CheckButton_toggled(button_pressed):
	
	if button_pressed==true:# store visbility of nodes and then hide them
		node_array.clear()
		nodes_visibility_status.clear()
		for i in get_parent().get_children():
			if i!=graphs_cL_cD and i!=self and i!=button_screenshot and i!=m_slider and i!=gamma_slider:
				node_array.append(i)
				nodes_visibility_status.append(i.visible)
				i.hide()
	
	if button_pressed==false: # chnage back to normal visibility
		var count=-1
		for i in node_array:
			count+=1
			i.visible=nodes_visibility_status[count]
			
	pass # Replace with function body.
