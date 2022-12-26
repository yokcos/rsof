extends Node2D


func _ready() -> void:
	Game.gameholder = self
	
	Game.switch_scene( load("res://levelselect/levelselect.tscn") )


func switch_scene(which: PackedScene):
	for i in $scene.get_children():
		i.queue_free()
	$scene.add_child(which.instance())
