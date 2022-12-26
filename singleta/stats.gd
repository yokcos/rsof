extends Node


var time: float = 0 setget set_time
var deaths: int = 0 setget set_deaths

signal time_changed
signal deaths_changed


func set_time(what: float):
	time = what
	emit_signal("time_changed")

func set_deaths(what: int):
	deaths = what
	emit_signal("deaths_changed")
