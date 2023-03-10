extends Node


var levels: Dictionary = {}
var unlocked: Array = [Vector2()]
var complete: Array = []

var in_level: bool = false
var current_level: Vector2 = Vector2()
var previous_level: Vector2 = Vector2()

const level_select_screen: PackedScene = preload("res://levelselect/levelselect.tscn")

signal level_entered
signal level_exited


func _ready() -> void:
	register_levels()
	load_progress()


func enter_level(which: Vector2):
	if levels.has(which):
		current_level = which
		previous_level = which
		in_level = true
		Game.switch_scene( levels[which] )
		
		emit_signal("level_entered", which)
	else:
		print("Attempting to enter nonexistent level %s" % which)
		get_tree().quit()

func complete_level(where: Vector2 = current_level):
	if !complete.has(where):
		complete.append(where)
		unlock_surrounding_levels(where)
		save_progress()
	
	exit_level()

func exit_level():
	Game.switch_scene( level_select_screen )
	
	emit_signal("level_exited")

func unlock_surrounding_levels(where: Vector2 = current_level):
	var directions = [
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0),
		Vector2( 0,-1),
	]
	
	for i in directions:
		var target_level = where + i
		
		if target_level == Vector2(0, -1):
			# Final level
			var adjacents = 0
			
			for j in directions:
				if unlocked.has(target_level + j):
					adjacents += 1
			
			if adjacents >= 3:
				unlock_level(target_level)
		else:
			if levels.has(target_level):
				unlock_level(target_level)

func unlock_level(where: Vector2 = current_level):
	if !unlocked.has(where):
		unlocked.append(where)


func register_levels():
	var levels_path = "res://levels/"
	var dir = Directory.new()
	if dir.open(levels_path) == OK:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".tscn") and file_name != "_level.tscn":
				var full_path = levels_path + file_name
				var this_level = load(full_path)
				
				# Get its position
				var new_level = this_level.instance()
				var pos: Vector2 = new_level.pos
				new_level.queue_free()
				
				# Register it at last
				levels[pos] = this_level
			
			file_name = dir.get_next()
	else:
		print("No levels folder")
		get_tree().quit()

func save_progress():
	var file = File.new()
	file.open("user://progress.sav", File.WRITE)
	file.store_var(complete)
	file.store_var(unlocked)
	file.close()

func load_progress():
	var file = File.new()
	file.open("user://progress.sav", File.READ)
	if file.is_open():
		complete = file.get_var()
		unlocked = file.get_var()
		file.close()

func reset_progress():
	unlocked = [Vector2()]
	complete = []

