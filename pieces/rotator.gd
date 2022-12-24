tool
extends Node2D


export (float) var radius = 64 setget set_radius
export (float) var initial_angle = 0 # in degrees

var angle: float = 0 setget set_angle
var centre: Vector2 = Vector2()


func _ready() -> void:
	if !Engine.editor_hint:
		centre = position
		
		if !OS.is_debug_build():
			$preview.queue_free()
		else:
			visualise()
			$preview.raise()


func visualise():
	var points = PoolVector2Array()
	var pointcount = 16
	var initial_angle = deg2rad(angle)
	
	for i in range(pointcount + 1):
		points.append( Vector2(radius, 0).rotated(initial_angle + i * PI*2/pointcount) )
	
	points.append(Vector2())
	
	$preview.points = points


func set_radius(what: float):
	radius = what
	visualise()

func set_angle(what: float):
	angle = what
	
	var radians = deg2rad(what)
	# position = centre + Vector2(radius, 0).rotated(radians)
	rotation = radians
