extends Node


var gameholder: Node2D = null


func switch_scene(which: PackedScene):
	if is_instance_valid(gameholder):
		gameholder.switch_scene(which)
