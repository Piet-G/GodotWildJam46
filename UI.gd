extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Vote_pressed():
	OS.shell_open("https://www.google.com")


func _on_StartButton_pressed():
	get_tree().get_nodes_in_group("player")[0].start_game()
	get_tree().get_nodes_in_group("orby")[0].start_game()
	queue_free()


func _on_Quit_pressed():
	get_tree().quit()
