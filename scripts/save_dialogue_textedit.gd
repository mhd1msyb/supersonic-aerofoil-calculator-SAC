extends TextEdit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var error_message=get_parent().get_node("error_message")
var back_slash="\\"
var quote_mark='"'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextEdit_text_changed():
	if text.is_valid_identifier()==false:
		#error_message.text= back_slash[0] + ' / < > * ? : |' + quote_mark + 'and a number at the beginning are not allowed'
		error_message.show()
	else:
		error_message.hide()
		
	#text=text.replace(back_slash[0], " ").replace(quote_mark, " ")
#
#	if text.length()>=20:
#		text=text.substr(text.length(),text.length())
	pass # Replace with function body.
