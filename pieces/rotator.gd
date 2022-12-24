tool
extends Node2D


export (float) var angle = 90 setget set_angle
export (float) var standby_time = 1
export (float) var extend_time = 1
export (float) var active_time = 1
export (float) var retract_time = 1
export (float) var phase = 0 # In seconds
var total_time = standby_time + extend_time + active_time + retract_time


func _ready() -> void:
	if !Engine.editor_hint:
		$visual.hide()
		$visual.show()
	
	calculate_total_time()

func _process(delta: float) -> void:
	if !Engine.editor_hint:
		phase += delta
		var r_angle = deg2rad(angle)
		if phase >= total_time:
			phase -= total_time
		
		var t0 = standby_time
		var t1 = t0 + extend_time
		var t2 = t1 + active_time
		var t3 = t2 + retract_time
		
		if phase < t0:
			rotation = 0
		elif phase < t1:
			rotation = lerp(0, r_angle, (phase-t0) / extend_time)
		elif phase < t2:
			rotation = r_angle
		elif phase < t3:
			rotation = lerp(r_angle, 0, (phase-t2) / retract_time)


func calculate_total_time():
	total_time = standby_time + extend_time + active_time + retract_time

func set_angle(what: float):
	angle = what
	
	if Engine.editor_hint:
		var points = [Vector2()]
		var visualisation_radius: float = 32
		var point_count: float = 8
		
		for i in range(point_count + 1):
			points.append( Vector2(visualisation_radius, 0).rotated(deg2rad(angle) * i/point_count) )
		
		$visual.points = PoolVector2Array(points)
