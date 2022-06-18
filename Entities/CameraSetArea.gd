extends Area2D

export var limit_height = 1

func _on_CameraSetArea_body_entered(body):
	if(body.is_in_group("orby")):
		print("set")
		body.camera.world_limit_top = global_position.y - limit_height * get_viewport_rect().size.y
		body.camera.world_limit_bottom = global_position.y
