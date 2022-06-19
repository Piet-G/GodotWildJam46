extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var started = false
var vol = 0
var speed = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StartButton_pressed():
	get_tree().reload_current_scene()

func _on_Vote_pressed():
	OS.shell_open("https://www.google.com")

func _on_Quit_pressed():
	get_tree().quit()

func _process(delta):
	if(started):
		$AudioStreamPlayer.volume_db = $AudioStreamPlayer.volume_db - delta * speed
		if($AudioStreamPlayer.volume_db < -50):
			$AudioStreamPlayer.stop()
			queue_free()
