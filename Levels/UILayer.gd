extends CanvasLayer

func _process(delta):
	if(Input.is_action_just_pressed("menu")):

		if(get_child_count() > 0):
			for child in get_children():
				child.queue_free()
		else:
			add_child(preload("res://UI.tscn").instance())
