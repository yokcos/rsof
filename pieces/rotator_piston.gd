tool
extends "res://pieces/rotator.gd"


export (float) var starting_phase = 0

# The order in which these phases happen
export (float) var contract_sustain = 1
export (float) var extend_time = 1
export (float) var extend_sustain = 1
export (float) var contract_time = 1

export (float) var distance = 90 # in degrees

var total_duration = 4
var phase: float = 0


func _ready() -> void:
	if !Engine.editor_hint:
		total_duration = extend_time + extend_sustain + contract_time + contract_sustain
		phase = starting_phase

func _process(delta: float) -> void:
	if !Engine.editor_hint and total_duration > 0:
		phase += delta
		phase = fmod(phase, total_duration)
		
		if phase < contract_sustain:
			set_angle(initial_angle)
		elif phase < contract_sustain + extend_time:
			var subprogress: float = phase - contract_sustain
			var ratio: float = 0
			if extend_time > 0:
				ratio = subprogress / extend_time
			
			set_angle(initial_angle + distance*ratio)
		elif phase < contract_sustain + extend_time + extend_sustain:
			set_angle(initial_angle + distance)
		else:
			var subprogress: float = phase - contract_sustain - extend_time - extend_sustain
			var ratio: float = 0
			if extend_time > 0:
				ratio = subprogress / contract_time
			
			set_angle(initial_angle + distance*(1 - ratio))
