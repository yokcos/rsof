extends Node2D


var level_spacing = Vector2(192, 192)
var level_buttons: Dictionary = {}

const obj_level_button = preload("res://levelselect/level_button.tscn")


func _ready() -> void:
	deploy_level_buttons()
	select_level_at()


func deploy_level_buttons():
	for i in Levels.levels:
		var new_level_button = obj_level_button.instance()
		$levels.call_deferred("add_child", new_level_button)
		
		new_level_button.target_level = i
		new_level_button.position = i * level_spacing
		
		level_buttons[i] = new_level_button

func select_level_at(where: Vector2 = Vector2()):
	for i in level_buttons:
		var this_button = level_buttons[i]
		if this_button.target_level == where:
			this_button.to_be_selected = true
			break
