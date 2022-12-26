tool
extends Node2D


export (int) var squares = 4 setget set_squares
export (float) var radius = 128 setget set_radius
export (float) var angle = 0 setget set_angle

var obj_square = preload("res://entities/square.tscn")


func _ready() -> void:
	add_squares()


func clear_squares():
	for i in get_children():
		i.queue_free()

func add_squares():
	clear_squares()
	
	for i in range(squares):
		var this_angle = i * PI*2 / squares + deg2rad(angle)
		var this_pos = Vector2(radius, 0).rotated(this_angle)
		
		var new_square = obj_square.instance()
		add_child(new_square)
		new_square.position = this_pos


func set_squares(what: int):
	squares = what
	add_squares()

func set_radius(what: float):
	radius = what
	add_squares()

func set_angle(what: float):
	angle = what
	add_squares()
