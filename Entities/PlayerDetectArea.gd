class_name PlayerDetectArea
extends Area2D

func is_overlapping_player() -> bool:
	for body in get_overlapping_bodies():
		if(body.is_in_group("orby")):
			return true
	
	return false
