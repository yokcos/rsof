tool
extends Area2D


export (Vector2) var size = Vector2(1, 1) setget set_size
export (float) var frequency = 1
export (float) var duration = 1
export (float) var phase = 0

var base_size: Vector2 = Vector2(32, 32)


func _ready() -> void:
	add_to_group("icezones")
	
	if !Engine.editor_hint:
		apply_hitbox()
		apply_visual()


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
	$colouriser.polygon = points
	
	$sprite.texture = Game.ice_noise
	$sprite.material.set_shader_param("noise", Game.ice_mod)
	
	$sprite.region_enabled = true
	$sprite.region_rect.size = base_size*size


func set_size(what: Vector2):
	size = what
	
	if Engine.editor_hint:
		apply_hitbox()
		apply_visual()



func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		body.frictionless = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("players"):
		body.check_icezones()
