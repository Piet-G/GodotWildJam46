class_name Orby
extends KinematicBody2D

onready var sprite = $Sprites/Wings
onready var camera = $Camera
onready var light_animation_player = $LightAnimationPlayer

export var max_speed = 750
export var min_speed = 220
export var max_speed_distance = 500
export var min_speed_distance = 20
export var lit_speed = 50
export var close_to_mouse_treshold = 10



var is_lit = false
var was_lit = false

var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.player = get_tree().get_nodes_in_group("player")[0]
	
func start_game():
	game_started = true

func _physics_process(delta):
	if(game_started):
		was_lit = is_lit
		is_lit = Input.is_action_pressed("light")
		
		move_to_mouse()

func respawn_to(pos: Vector2):
	global_position = pos

func move_to_mouse():
	var final_speed
	
	var local_mouse_position = get_local_mouse_position()
	
	if(is_lit):
		final_speed = lit_speed
		
		if(is_lit != was_lit):
			light_animation_player.play("light")
	else:
		var lerp_weight = clamp(inverse_lerp(min_speed_distance, max_speed_distance, local_mouse_position.length()), 0.1, 1)
		final_speed = lerp(min_speed, max_speed, lerp_weight)
		
		if(is_lit != was_lit):
			light_animation_player.play("RESET")
	

	
	if(local_mouse_position.length() > close_to_mouse_treshold):
		sprite.flip_h = local_mouse_position.x < 0
		move_and_slide(get_local_mouse_position().normalized() * final_speed)
