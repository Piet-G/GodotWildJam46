extends Node2D

onready var particles = $ParticleOrigin/Particles2D
onready var light2D = $ParticleOrigin/Light2D
onready var laser_detection_area = $Area2D

export var is_lit = true setget set_lit

var light_timer = 0
var light_duration = 1

func set_lit_deferred(val):
	particles.emitting = val
	light2D.enabled = val

func set_lit(val: bool):
	is_lit = val

	call_deferred("set_lit_deferred", val)

func _ready():
	set_lit(is_lit)

func _physics_process(delta):
	if(not is_lit):
		var found = false
		for area in laser_detection_area.get_overlapping_areas():
			if(area.is_in_group("laser_tip") && area.get_parent().is_active):
				found = true
				
		if(found):
			light_timer += delta
			
			if(light_timer >= light_duration):
				set_lit(true)
		else:
			light_timer = 0
		

