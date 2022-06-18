class_name OrbyCamera
extends Camera2D

var player: Node2D = null

func _physics_process(delta):
	if(player):
		limit_left = player.global_position.x - get_viewport_rect().size.x
		limit_right = player.global_position.x + get_viewport_rect().size.x
		limit_top = player.global_position.y - get_viewport_rect().size.y
		limit_bottom = player.global_position.y + get_viewport_rect().size.y
