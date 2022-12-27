extends Node


var time: float = 0 setget set_time
var deaths: int = 0 setget set_deaths

signal time_changed
signal deaths_changed


func _ready() -> void:
	load_stats()
	Levels.connect("level_exited", self, "_on_level_exited")


func set_time(what: float):
	time = what
	emit_signal("time_changed")

func set_deaths(what: int):
	deaths = what
	emit_signal("deaths_changed")

func save_stats():
	var file = File.new()
	file.open("user://stats.sav", File.WRITE)
	file.store_float(time)
	file.store_16(deaths)
	file.close()

func load_stats():
	var file = File.new()
	file.open("user://stats.sav", File.READ)
	if file.is_open():
		set_time( file.get_float() )
		set_deaths( file.get_16() )
		file.close()

func reset_stats():
	time = 0
	deaths = 0


func _on_level_exited():
	save_stats()
