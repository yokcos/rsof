tool
extends Area2D


export (Vector2) var size = Vector2(1, 1) setget set_size
export (float) var frequency = 1
export (float) var duration = 1
export (float) var phase = 0

var base_size: Vector2 = Vector2(32, 32)

var inactive_colour: Color = Color("ffffff")
var active_colour: Color = Color("ffffff")


func _ready() -> void:
	if !Engine.editor_hint:
		if phase > 0:
			$timer.start(phase)
			$timer.wait_time = frequency
		else:
			$timer.start(frequency)
		
		apply_hitbox()
		apply_visual()
		
		inactive_colour = $visual.color
		active_colour = inactive_colour
		active_colour.a = 1


func freeze():
	for i in get_overlapping_bodies():
		if i.is_in_group("players"):
			i.slow_time = max(duration, i.slow_time)
	
	$tween.interpolate_property(
		$visual, "color",
		active_colour, inactive_colour, duration/2,
		Tween.TRANS_CUBIC, Tween.EASE_OUT
	)
	$tween.start()

func apply_hitbox():
	var halfsize = base_size*size / 2
	$hitbox.shape = null
	var new_shape = RectangleShape2D.new()
	new_shape.extents = halfsize
	$hitbox.shape = new_shape

func apply_visual():
	var halfsize = base_size*size / 2
	
	var points: PoolVector2Array = PoolVector2Array()
	points.append(halfsize * Vector2(-1, -1))
	points.append(halfsize * Vector2( 1, -1))
	points.append(halfsize * Vector2( 1,  1))
	points.append(halfsize * Vector2(-1,  1))
	$visual.polygon = points

func set_size(what: Vector2):
	size = what
	
	if Engine.editor_hint:
		apply_hitbox()
		apply_visual()

func _on_timer_timeout() -> void:
	freeze()
