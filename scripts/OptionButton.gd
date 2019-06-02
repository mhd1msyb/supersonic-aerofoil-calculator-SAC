extends OptionButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	for i in range (10):
		add_item(str(i),i)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
