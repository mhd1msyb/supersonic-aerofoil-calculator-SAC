#Copyright (c) 2019 Mehdi Msayib#
extends TextEdit


onready var error_message=get_parent().get_node("error_message")
var back_slash="\\"
var quote_mark='"'




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
