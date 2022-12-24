tool
extends "res://pieces/rotator.gd"


export (float) var speed = 30 # In degrees per second



func _ready() -> void:
	if !Engine.editor_hint:
		$preview.hide()

func _process(delta: float) -> void:
	if !Engine.editor_hint:
		set_angle(angle + speed*delta)
