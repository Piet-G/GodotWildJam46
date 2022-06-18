class_name Orby
extends KinematicBody2D

onready var sprite = $Sprite
onready var camera = $Camera

export var speed = 200
export var lit_speed = 50
export var close_to_mouse_treshold = 400

var is_lit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	is_lit = Input.is_action_pressed("light")
	
	move_to_mouse()

func move_to_mouse():
	var final_speed
	
	if(is_lit):
		final_speed = lit_speed
	else:
		final_speed = speed
	
	var local_mouse_position = get_local_mouse_position()
	
	if(local_mouse_position.length() > close_to_mouse_treshold):
		sprite.flip_h = local_mouse_position.x < 0
		move_and_slide(get_local_mouse_position().normalized() * final_speed)
