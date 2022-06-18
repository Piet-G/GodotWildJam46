extends Node2D
export var speed = 64

var test_position = Vector2(600, 400)

func move_to_waypoint(delta: float, waypoint: Vector2):
	position += global_position.direction_to(waypoint) * delta * speed

func _physics_process(delta):
	move_to_waypoint(delta, test_position)

