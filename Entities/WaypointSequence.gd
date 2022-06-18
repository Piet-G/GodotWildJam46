class_name WaypointSequence
extends Node2D

func get_waypoints() -> PoolVector2Array:
	var positions : PoolVector2Array = []
	
	for child in get_children():
		if(child.is_in_group("waypoint")):
			positions.append(child.global_position)
	
	return positions;
