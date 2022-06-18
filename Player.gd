class_name Player
extends Node2D
export var speed = 64

onready var light_detection_area = $LightDetectionArea
onready var animation_player = $AnimationPlayer

export(NodePath) var waypoint_1
export(NodePath) var door_1
export(NodePath) var waypoint_3


var current_waypoint_sequence : WaypointSequence
var current_waypoint_index = 0

var waypoint_distance_threshold = 10
var waypoint_sequence_count = 0

var last_respawn_point: RespawnPoint

func is_lit() -> bool:
	for area in light_detection_area.get_overlapping_areas():
		if(area.is_in_group("light")):
			return true
	
	return false
	
func move_to_waypoint(delta: float, waypoint: Vector2):
	position += global_position.direction_to(waypoint) * delta * speed
	
func has_reached_waypoint(waypoint: Vector2) -> bool:
	return global_position.distance_to(waypoint) <= waypoint_distance_threshold
	

func get_next_waypoint_sequence() -> WaypointSequence:
	match waypoint_sequence_count:
		0:
			print("Waiting")
			return null
		1: 
			print("Advancing")
			return get_node(waypoint_3) as WaypointSequence
			
	print("Finished")
	return null

func has_finished_waiting() -> bool:
	match waypoint_sequence_count:
		1:
			return get_node(door_1).is_open
	
	return false

func advance_waypoint_sequence():
	current_waypoint_index = 0
	current_waypoint_sequence = get_next_waypoint_sequence()
	waypoint_sequence_count += 1
	
func navigate_waypoint_sequence(delta: float):
	if(not current_waypoint_sequence):
		play_or_continue_animation("idle")
		if(has_finished_waiting()):
			advance_waypoint_sequence()
	else:
		var current_waypoint = current_waypoint_sequence.get_waypoints()[current_waypoint_index]
		
		if(is_lit()):
			move_to_waypoint(delta, current_waypoint)
			play_or_continue_animation("walk")
		else:
			play_or_continue_animation("idle")
		
		if(has_reached_waypoint(current_waypoint)):
			current_waypoint_index += 1
		
		if(current_waypoint_index >= current_waypoint_sequence.get_waypoints().size()):
			advance_waypoint_sequence()

func respawn():
	current_waypoint_index = last_respawn_point.saved_waypoint_index
	current_waypoint_sequence = last_respawn_point.saved_waypoint_sequence
	waypoint_sequence_count = last_respawn_point.saved_waypoint_sequence_count
	
	global_position = current_waypoint_sequence.get_waypoints()[current_waypoint_index]

func _physics_process(delta):
	navigate_waypoint_sequence(delta)

func _ready():
	current_waypoint_sequence = get_node(waypoint_1)


func play_or_continue_animation(animation: String):
	if(animation_player.current_animation != animation):
		animation_player.play(animation)
