extends Node


var gameholder: Node2D = null
var ice_noise: Texture = null
var ice_mod: Texture = null


func _ready() -> void:
	create_ice_noise()


func switch_scene(which: PackedScene):
	if is_instance_valid(gameholder):
		gameholder.switch_scene(which)

func create_ice_noise():
	var noise = OpenSimplexNoise.new()
	noise.seed = 0
	var img: Image = noise.get_seamless_image(512)
	var tex: ImageTexture = ImageTexture.new()
	tex.create_from_image(img)
	ice_noise = tex
	
	noise.seed = 1
	img = noise.get_seamless_image(512)
	tex = ImageTexture.new()
	tex.create_from_image(img)
	ice_mod = tex

