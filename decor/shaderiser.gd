extends ColorRect


var tex: Texture = null

var default_vi: float = 0.5
var vignette_intensity: float = default_vi


func _ready() -> void:
	generate_texture()

func _process(delta: float) -> void:
	var player: KinematicBody2D
	var players: Array = get_tree().get_nodes_in_group("players")
	if players.size() > 0:
		player = players[0]
		
		material.set_shader_param("centre", player.global_position / rect_size)
		if player.slow_time <= 0:
			default_vi = 0.5
		else:
			default_vi = 1.5
	
	vignette_intensity = lerp(vignette_intensity, default_vi, delta*4)
	material.set_shader_param("vignette_intensity", vignette_intensity)


func generate_texture():
	var noise = OpenSimplexNoise.new()
	var img: Image = noise.get_seamless_image(1024)
	var tex: ImageTexture = ImageTexture.new()
	tex.create_from_image(img)
	
	material.set_shader_param("noise", tex)
