tool
extends Node2D


export (int) var squares = 4 setget set_squares
export (float) var spacing = 64 setget set_spacing

var obj_square = preload("res://entities/square.tscn")


func _ready() -> void:
	add_squares()
	
	if !Engine.editor_hint:
		$preview.hide()
	
	if OS.is_debug_build():
		$preview.raise()
		$preview.points = PoolVector2Array([
			Vector2(),
			Vector2((squares-1) * spacing, 0)
		])
	else:
		$preview.queue_free()


func clear_squares():
	for i in get_children():
		if i is Area2D:
			i.queue_free()

func add_squares():
	clear_squares()
	
	for i in range(squares):
		var new_square = obj_square.instance()
		add_child(new_square)
		new_square.position.x = i*spacing


func set_squares(what: int):
	squares = what
	add_squares()

func set_spacing(what: float):
	spacing = what
	add_squares()
