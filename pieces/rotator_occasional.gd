tool
extends "res://pieces/rotator.gd"


export (float) var initial_phase = 0

export (float) var rest_time = 1
export (float) var move_time = 1
export (float) var move_distance = 90

var total_duration: float = 0
var phase: float = 0

var move_target: float = 0


func _ready() -> void:
	if !Engine.editor_hint:
		total_duration = rest_time + move_time
		phase = initial_phase


func _process(delta: float) -> void:
	if !Engine.editor_hint and total_duration > 0:
		phase += delta
		
		if phase >= rest_time:
			if move_time > 0:
				if phase < rest_time + delta:
					move_target = angle + move_distance
				
				var speed = move_distance / move_time
				set_angle(angle + speed * delta)
			else:
				move_target = angle + move_distance
				set_angle(move_target)
		else:
			set_angle(move_target)
		
		phase = fmod(phase, total_duration)
			
