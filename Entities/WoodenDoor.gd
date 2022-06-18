class_name WoodenDoor
extends Area2D

var is_open = false

var light_timer = 0
var light_duration = 1

func _physics_process(delta):
	if(not is_open):
		var found = false
		for area in get_overlapping_areas():
			if(area.is_in_group("laser_tip") && area.get_parent().is_active):
				found = true
				
		if(found):
			light_timer += delta
			
			if(light_timer >= light_duration):
				is_open = true
				$Sprite.visible = false
		else:
			light_timer = 0
