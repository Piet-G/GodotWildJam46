extends Node2D


# Declare member variables here. Examples:
# var a = 2
var drops
var winds
var rng = RandomNumberGenerator.new()
var drop_playing = false
var wind_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	drops = [$AudioStreamPlayer,$AudioStreamPlayer2,$AudioStreamPlayer3,$AudioStreamPlayer4]
	winds = [$AudioStreamPlayer5,$AudioStreamPlayer6,$AudioStreamPlayer7,$AudioStreamPlayer8]

	rng.randomize()
	$DropSounds.start(rng.randf_range(5.0, 15.0))
	$WindSounds.start(rng.randf_range(10.0, 30.0))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DropSounds_timeout():
	drops[rng.randi_range(0,3)].play()
	$DropSounds.start(rng.randf_range(2.0, 10.0)) # Replace with function body.


func _on_WindSounds_timeout():
	winds[rng.randi_range(0,3)].play()
	$WindSounds.start(rng.randf_range(10.0, 20.0)) # Replace with function body.
