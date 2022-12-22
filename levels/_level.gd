class_name Level
extends Node2D


export (String) var title = "Level Name"
export (Vector2) var pos = Vector2(0, 0)


func _ready() -> void:
	$underbar/title.text = title
