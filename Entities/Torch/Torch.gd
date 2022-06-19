extends Node2D

onready var particles = $ParticleOrigin/Particles2D
onready var light2D = $ParticleOrigin/Light2D
onready var laser_detection_area = $Area2D

export var is_lit = true
var is_physically_lit = false

var light_timer = 0
var light_duration = 1
var max_distance = 1600

func _ready():
	is_physically_lit = false

func set_lit(val):
	is_physically_lit = val
	particles.emitting = val
	light2D.enabled = val

func check_distance():
	var in_range = get_tree().get_nodes_in_group("orby")[0].global_position.distance_to(global_position) <= max_distance
	var final_lit = in_range && is_lit
	set_lit(final_lit)

func _physics_process(delta):
	check_distance()	
	if(not is_lit):
		var found = false
		for area in laser_detection_area.get_overlapping_areas():
			if(area.is_in_group("laser_tip") && area.get_parent().is_active):
				found = true
				
		if(found):
			light_timer += delta
			
			if(light_timer >= light_duration):
				is_lit = true
		else:
			light_timer = 0
		

