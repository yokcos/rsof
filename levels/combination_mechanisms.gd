extends Node2D


export (float) var extra_phase = 0.5


func _ready() -> void:
	for i in get_children():
		i.phase += extra_phase
