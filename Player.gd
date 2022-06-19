class_name Player
extends Node2D
export var speed = 100

onready var light_detection_area = $LightDetectionArea
onready var animation_player = $AnimationPlayer

export(NodePath) var waypoint_1
export(NodePath) var waypoint_2_1
export(NodePath) var waypoiny_2_detect_area
export(NodePath) var waypoint_2_2
export(NodePath) var waypoint_2_3
export(NodePath) var waypoiny_2_3_detect_area
export(NodePath) var waypoint_2_4
export(NodePath) var door_1
export(NodePath) var waypoint_3
export(NodePath) var waypoint_4_1
export(NodePath) var waypoiny_4_detect_area
export(NodePath) var waypoint_4_2
export(NodePath) var waypoint_5_1
export(NodePath) var waypoiny_5_detect_area
export(NodePath) var waypoint_5_2

var current_waypoint_sequence : WaypointSequence
var current_waypoint_index = 0

var waypoint_distance_threshold = 10
var waypoint_sequence_count = -1
var walk_playing = false

var last_respawn_point: RespawnPoint
var game_started = false

func start_game():
	game_started = true

func is_lit() -> bool:
	for area in light_detection_area.get_overlapping_areas():
		if(area.is_in_group("light")):
			return true
	
	for body in light_detection_area.get_overlapping_bodies():
		if(body.is_in_group("light")):
			return true
	
	return false
	
func move_to_waypoint(delta: float, waypoint: Vector2):
	position += global_position.direction_to(waypoint) * delta * speed
	
func has_reached_waypoint(waypoint: Vector2) -> bool:
	return global_position.distance_to(waypoint) <= waypoint_distance_threshold
	

func get_next_waypoint_sequence() -> WaypointSequence:
	match waypoint_sequence_count:
		-1: 
			return get_node(waypoint_1) as WaypointSequence
		0:
			if(get_node(waypoiny_2_detect_area).is_overlapping_player()):
				return get_node(waypoint_2_2) as WaypointSequence
			else:
				return get_node(waypoint_2_1) as WaypointSequence
		1:
			if(get_node(waypoiny_2_3_detect_area).is_overlapping_player()):
				return get_node(waypoint_2_4) as WaypointSequence
			else:
				return get_node(waypoint_2_3) as WaypointSequence
		2: 
			return null
		3:
			return get_node(waypoint_3) as WaypointSequence
		4: 
			if(get_node(waypoiny_4_detect_area).is_overlapping_player()):
				return get_node(waypoint_4_2) as WaypointSequence
			else:
				return get_node(waypoint_4_1) as WaypointSequence
		5:
			if(get_node(waypoiny_5_detect_area).is_overlapping_player()):
				return get_node(waypoint_5_2) as WaypointSequence
			else:
				return get_node(waypoint_5_1) as WaypointSequence
		6:
			get_tree().get_nodes_in_group("orby")[0].game_started = false
			animation_player.play("diamond")
			waypoint_sequence_count = -1
			return null
			
	return null

func has_finished_waiting() -> bool:
	match waypoint_sequence_count:
		-1:
			return game_started
		3:
			return get_node(door_1).is_open
	
	return false

func advance_waypoint_sequence():
	current_waypoint_index = 0
	current_waypoint_sequence = get_next_waypoint_sequence()
	waypoint_sequence_count += 1
	
func navigate_waypoint_sequence(delta: float):
	if(not current_waypoint_sequence):
		if(is_lit()):
			$WalkSound.playing = false
			walk_playing = false
			play_or_continue_animation("idle")
		else:
			$WalkSound.playing = false
			walk_playing = false
			play_or_continue_animation("scared")
		if(has_finished_waiting()):
			advance_waypoint_sequence()
	else:
		var current_waypoint = current_waypoint_sequence.get_waypoints()[current_waypoint_index]
		
		if(is_lit()):
			move_to_waypoint(delta, current_waypoint)
			play_or_continue_animation("walk")
			if(!walk_playing):
				$WalkSound.playing = true
				walk_playing = true
		else:
			play_or_continue_animation("scared")
			$WalkSound.playing = false
			walk_playing = false
		
		if(has_reached_waypoint(current_waypoint)):
			current_waypoint_index += 1
		
		if(current_waypoint_index >= current_waypoint_sequence.get_waypoints().size()):
			advance_waypoint_sequence()

func respawn():
	$DeathSound.play()
	current_waypoint_index = last_respawn_point.saved_waypoint_index
	current_waypoint_sequence = last_respawn_point.saved_waypoint_sequence
	waypoint_sequence_count = last_respawn_point.saved_waypoint_sequence_count
	
	global_position = current_waypoint_sequence.get_waypoints()[current_waypoint_index]
	var orby = get_tree().get_nodes_in_group("orby")[0]
	orby.respawn_to($OrbyRespawnPosition.global_position)

func _physics_process(delta):
	navigate_waypoint_sequence(delta)

func play_or_continue_animation(animation: String):
	if(animation_player.current_animation != animation):
		animation_player.play(animation)
