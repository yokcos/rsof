class_name Level
extends Node2D


export (String) var title = "Level Name"
export (Vector2) var pos = Vector2(0, 0)

const obj_overlay = preload("res://decor/overlay.tscn")


func _ready() -> void:
	$underbar/title.text = title
	
	Stats.connect("deaths_changed", self, "_on_deaths_changed")
	Stats.connect("time_changed", self, "_on_time_changed")
	
	update_deaths()
	update_time()

func _process(delta: float) -> void:
	Stats.time += delta

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Levels.exit_level()


func update_deaths():
	$underbar/deaths.text = "%s Deaths" % Stats.deaths

func update_time():
	var time = floor(Stats.time)
	
	var seconds = fmod(time, 60)
	var minutes = fmod(floor(time/60), 60)
	var hours = floor(time/3600)
	
	var s_seconds = str(seconds).pad_zeros(2)
	var s_minutes = str(minutes).pad_zeros(2)
	var s_hours = str(hours).pad_zeros(2)
	
	$underbar/time.text = "%s:%s:%s" % [s_hours, s_minutes, s_seconds]


func _on_deaths_changed():
	update_deaths()

func _on_time_changed():
	update_time()
