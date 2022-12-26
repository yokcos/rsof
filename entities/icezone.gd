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
	
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	var img: Image = noise.get_seamless_image(calculate_texture_size())
	var tex: ImageTexture = ImageTexture.new()
	tex.create_from_image(img)
	
	$sprite.texture = tex
	
	$sprite.region_enabled = true
	$sprite.region_rect.size = base_size*size
	
	noise.seed = randi()
	img = noise.get_seamless_image(calculate_texture_size())
	tex = ImageTexture.new()
	tex.create_from_image(img)
	
	$sprite.material.set_shader_param("noise", tex)

func calculate_texture_size():
	var largest = max(size.x, size.y)
	return largest * 32


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
