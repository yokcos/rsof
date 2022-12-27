extends Node2D


var rotation_speed: float = 45
var unlocked: bool = false
var to_be_selected = false
var selected: bool = false
var target_level: Vector2 = Vector2()


func _ready() -> void:
	show_completion()

func _process(delta: float) -> void:
	$polygon.rotation_degrees += rotation_speed * delta
	$selected.rotation_degrees += rotation_speed * delta
	$complete.rotation_degrees += rotation_speed * delta
	
	if selected != to_be_selected:
		set_selected(to_be_selected)

func _input(event: InputEvent) -> void:
	if selected:
		if event.is_action_pressed("ui_accept"):
			Levels.enter_level(target_level)
		
		if event.is_action_pressed("move_up"):
			select_other($rayU)
		if event.is_action_pressed("move_down"):
			select_other($rayD)
		if event.is_action_pressed("move_left"):
			select_other($rayL)
		if event.is_action_pressed("move_right"):
			select_other($rayR)


func show_completion():
	if !Levels.complete.has(target_level):
		$complete.hide()

func select_other(ray: RayCast2D):
	if ray.is_colliding():
		var target = ray.get_collider().get_parent()
		target.to_be_selected = true
		to_be_selected = false


func set_selected(what: bool):
	selected = what
	
	$selected.visible = selected
