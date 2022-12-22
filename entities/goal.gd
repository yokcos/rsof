tool
extends Area2D


export (Vector2) var size = Vector2(1, 1) setget set_size
var base_size: Vector2 = Vector2(32, 32)


func set_size(what: Vector2):
	size = what
	
	var halfsize = base_size*what / 2
	$hitbox.shape = null
	var new_shape = RectangleShape2D.new()
	new_shape.extents = halfsize
	$hitbox.shape = new_shape
	$sprite.region_rect.size = halfsize*2

