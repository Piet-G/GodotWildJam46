extends Node2D

onready var particles = $Particles2D
onready var laser_detection_area = $Area2D

var light_timer = 0
var light_duration = 1

func _physics_process(delta):
	var found = false
	for area in laser_detection_area.get_overlapping_areas():
		if(area.is_in_group("laser_tip") && area.get_parent().is_active):
			found = true
			
	if(found):
		light_timer += delta
		
		if(light_timer >= light_duration):
			light()
	else:
		light_timer = 0
		
func light():
	particles.emitting = true
