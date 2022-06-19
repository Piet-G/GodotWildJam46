extends Area2D

func _process(delta):
	for body in get_overlapping_bodies():
		if(body.is_in_group("orby")):
			get_parent().visible = true
			return
	
	get_parent().visible = false
