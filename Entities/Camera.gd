class_name OrbyCamera
extends Camera2D

var world_limit_top = 1000000
var world_limit_bottom = -1000000

var player: Node2D = null

func _physics_process(delta):
	if(player):
		limit_left = player.global_position.x - get_viewport_rect().size.x
		limit_right = player.global_position.x + get_viewport_rect().size.x
		limit_top = max(player.global_position.y - get_viewport_rect().size.y, world_limit_top)
		limit_bottom = min(player.global_position.y + get_viewport_rect().size.y, world_limit_bottom)
