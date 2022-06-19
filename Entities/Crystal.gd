extends Node2D

onready var detection_area = $OrbyDetectionArea
onready var laser = $Laser

export var max_distance = 400
export var min_distance = 20

func find_overlapping_orby() -> Orby:
	for body in detection_area.get_overlapping_bodies():
		if(body.is_in_group("orby")):
			return body
	
	return null
	

func _physics_process(delta):
	var orby = find_overlapping_orby()
	
	laser.is_active = orby && orby.is_lit
	
	if(laser.is_active):
		var distance = orby.global_position.distance_to(laser.global_position)
		laser.rotation = laser.global_position.angle_to_point(orby.global_position) - rotation
		var lerp_weigth = inverse_lerp(min_distance, max_distance, distance)
		laser.scale.x = lerp(0.5, 4, lerp_weigth)
	
