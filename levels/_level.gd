class_name Level
extends Node2D


export (String) var title = "Level Name"
export (Vector2) var pos = Vector2(0, 0)

const obj_overlay = preload("res://decor/overlay.tscn")


func _ready() -> void:
	$underbar/title.text = title
	
	var new_overlay = obj_overlay.instance()
	add_child(new_overlay)
