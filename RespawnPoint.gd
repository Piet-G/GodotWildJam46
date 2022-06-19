class_name RespawnPoint
extends Area2D

var saved_waypoint_sequence_count
var saved_waypoint_index
var saved_waypoint_sequence

var is_set = false

func _on_RespawnPoint_area_entered(area):
	if(not is_set && area.is_in_group("player")):
		print("Set respawn point", area.waypoint_sequence_count, area.current_waypoint_index)
		is_set = true
		area.last_respawn_point = self
		saved_waypoint_sequence_count = area.waypoint_sequence_count
		saved_waypoint_index = area.current_waypoint_index
		saved_waypoint_sequence = area.current_waypoint_sequence
