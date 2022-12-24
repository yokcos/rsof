tool
extends "res://pieces/rotator.gd"


export (float) var initial_phase = 0

export (float) var amplitude = 90 # degrees
export (float) var period = 2

var phase: float = 0


func _ready() -> void:
	if !Engine.editor_hint:
		phase = initial_phase
		
		$preview.hide()


func _process(delta: float) -> void:
	if !Engine.editor_hint and period > 0:
		phase += delta
		phase = fmod(phase, period)
		
		var ratio: float = phase / period
		set_angle(initial_angle + amplitude * sin(ratio * PI*2))
