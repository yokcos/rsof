tool
extends Node2D


export (Vector2) var offset = Vector2() setget set_offset
export (float) var standby_time = 1
export (float) var extend_time = 1
export (float) var active_time = 1
export (float) var retract_time = 1
export (float) var phase = 0 # In seconds
var total_time = standby_time + extend_time + active_time + retract_time
var base_position: Vector2 = Vector2()


func _ready() -> void:
	base_position = position
	
	if !Engine.editor_hint:
		$visual.hide()
	
	calculate_total_time()

func _process(delta: float) -> void:
	if !Engine.editor_hint:
		phase += delta
		if phase >= total_time:
			phase -= total_time
		
		var t0 = standby_time
		var t1 = t0 + extend_time
		var t2 = t1 + active_time
		var t3 = t2 + retract_time
		
		if phase < t0:
			position = base_position
		elif phase < t1:
			position = lerp(base_position, base_position+offset, (phase-t0) / extend_time)
		elif phase < t2:
			position = base_position + offset
		elif phase < t3:
			position = lerp(base_position+offset, base_position, (phase-t2) / retract_time)


func calculate_total_time():
	total_time = standby_time + extend_time + active_time + retract_time

func set_offset(what: Vector2):
	offset = what
	
	if Engine.editor_hint:
		var points = [
			Vector2(),
			what,
		]
		$visual.points = PoolVector2Array(points)
