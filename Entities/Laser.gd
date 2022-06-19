class_name Laser
extends Node2D

var is_active = false setget set_active
var sound_playing = false

func set_active(val):
	is_active = val
	$Light2D.enabled = val
	if(val && !sound_playing):
		sound_playing = true
		$AudioStreamPlayer2D.playing = true
	if(!val):
		sound_playing = false
		$AudioStreamPlayer2D.playing = false

func get_collision_position() -> Vector2:
	if($RayCast2D.is_colliding()):
		return $RayCast2D.get_collision_point()
	else:
		return Vector2(0,0)
