extends Node2D


var level_spacing = Vector2(192, 192)

const obj_level_button = preload("res://levelselect/level_button.tscn")


func _ready() -> void:
	$levels/lv0_0.to_be_selected = true


func deploy_level_buttons():
	for i in Levels.levels:
		var new_level_button = obj_level_button.instance()
		$levels.add_child(new_level_button)
		
		new_level_button.target_level = Levels.levels[i]
		new_level_button.position = i * level_spacing
