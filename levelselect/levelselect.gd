extends Node2D


var level_spacing = Vector2(192, 192)

const obj_level_button = preload("res://levelselect/level_button.tscn")


func _ready() -> void:
	deploy_level_buttons()
	select_level_at()


func deploy_level_buttons():
	for i in Levels.levels:
		var new_level_button = obj_level_button.instance()
		$levels.add_child(new_level_button)
		
		new_level_button.target_level = i
		new_level_button.position = i * level_spacing

func select_level_at(where: Vector2 = Vector2()):
	for i in $levels.get_children():
		if i.target_level == where:
			i.to_be_selected = true
			break
