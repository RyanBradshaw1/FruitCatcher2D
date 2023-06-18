extends ColorRect

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://MainMenu.tscn")
		queue_free()
