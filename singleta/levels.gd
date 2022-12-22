extends Node


var levels: Dictionary = {}
var unlocked: Dictionary = {}
var complete: Dictionary = {}

var in_level: bool = false
var current_level: Vector2 = Vector2()


func enter_level(which: Vector2):
	if levels.has(which):
		current_level = which
		in_level = true
		get_tree().change_scene_to( levels[which] )
	else:
		print("Attempting to enter nonexistent level %s" % which)
		get_tree().quit()

func exit_level():
	pass


func register_levels():
	var levels_path = "res://levels/"
	var dir = Directory.new()
	if dir.open(levels_path) == OK:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".tscn") and file_name != "level.tscn":
				var full_path = levels_path + file_name
				var this_level = load(full_path)
	else:
		print("No levels folder")
		get_tree().quit()

