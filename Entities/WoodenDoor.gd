class_name WoodenDoor
extends Area2D

var is_open = false

var light_timer = 0
var light_duration = 4

func _physics_process(delta):
	if(not is_open):
		var found = false
		var height = 0
		for area in get_overlapping_areas():
			if(area.is_in_group("laser_tip") && area.get_parent().is_active):
				found = true
				height = area.get_parent().get_collision_position().y
				
		if(found):
			$Particles2D2.global_position.y = height
			var weight = inverse_lerp(0, light_duration, light_timer)
			
			$Particles2D2.scale_amount = lerp(0.05, 0.2, weight)
			$Particles2D2.initial_velocity = lerp(50, 200, weight)
			
			$Particles2D2.emitting = true
			light_timer += delta
			
			if(light_timer >= light_duration):
				open()
		else:
			light_timer = 0
			$Particles2D2.emitting = false
		
func open():
	is_open = true
	$Sprite.visible = false
	$StaticBody2D.collision_mask = 0
	$StaticBody2D.collision_layer = 0
	$LightOccluder2D.light_mask = 0
	$Particles2D2.emitting = false
	
