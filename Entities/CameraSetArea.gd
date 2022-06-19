extends Area2D

var no_care_distance = 50
export var limit_height = 1
export var immediate = false

func _on_CameraSetArea_body_entered(body):
	if(body.is_in_group("orby")):
		if(immediate):
			body.camera.world_limit_top = global_position.y - limit_height * get_viewport_rect().size.y
			body.camera.world_limit_bottom = global_position.y
		else:
			if(abs(body.camera.world_limit_top - global_position.y - limit_height * get_viewport_rect().size.y) > no_care_distance):
				$TopTween.interpolate_property(body.camera, "world_limit_top", body.camera.world_limit_top, global_position.y - limit_height * get_viewport_rect().size.y, 1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
				$TopTween.start()
			if(abs(body.camera.world_limit_bottom - global_position.y) > no_care_distance):
				$BottomTween.interpolate_property(body.camera, "world_limit_bottom", body.camera.world_limit_bottom, global_position.y, 1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
				$BottomTween.start()

func _on_TopTween_tween_step(object, key, elapsed, value):
	pass # Replace with function body.


func _on_BottomTween_tween_step(object, key, elapsed, value):
	pass # Replace with function body.
