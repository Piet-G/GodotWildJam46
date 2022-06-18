tool
extends StaticBody2D

func _physics_process(delta):
	$Sprite.material.set_shader_param("sprite_scale", global_scale)

