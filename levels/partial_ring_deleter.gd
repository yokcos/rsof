extends Node


func _ready() -> void:
	call_deferred("activate")


func activate() -> void:
	for square in get_node("../square_ring0").get_children():
		if square is Area2D:
			if abs(square.position.y) < 64 or abs(square.position.x) < 64:
				square.queue_free()
