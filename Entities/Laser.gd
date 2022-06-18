class_name Laser
extends Node2D

var is_active = false setget set_active

func set_active(val):
	is_active = val
	$Light2D.enabled = val
