extends KinematicBody2D


var rotation_speed: float = 30

var velocity: Vector2 = Vector2()
var acceleration: float = 3000
var friction: float = 10

var slow_time: float = 0

var spawn_pos: Vector2 = Vector2()

var default_colour: Color = Color("3a373d")
var slow_colour: Color = Color("50545c")


func _ready() -> void:
	add_to_group("players")
	spawn_pos = global_position

func _process(delta: float) -> void:
	$triangle.rotation_degrees += rotation_speed * delta
	
	tractutate(delta)
	frictutate(delta)
	
	if slow_time > 0:
		var slow_factor: float = 3
		velocity = move_and_slide(velocity/slow_factor) * slow_factor
		
		slow_time -= delta
		$triangle.color = slow_colour
	else:
		velocity = move_and_slide(velocity)
		$triangle.color = default_colour

func _input(event: InputEvent) -> void:
	var jump_ratio = 1.0/25.0
	var impulse = acceleration * jump_ratio
	
	if event.is_action_pressed("move_up"):
		velocity.y -= impulse
	if event.is_action_pressed("move_down"):
		velocity.y += impulse
	if event.is_action_pressed("move_left"):
		velocity.x -= impulse
	if event.is_action_pressed("move_right"):
		velocity.x += impulse


func tractutate(delta: float):
	var traction: Vector2 = Vector2()
	
	if Input.is_action_pressed("move_up"):
		traction.y -= 1
	if Input.is_action_pressed("move_down"):
		traction.y += 1
	if Input.is_action_pressed("move_left"):
		traction.x -= 1
	if Input.is_action_pressed("move_right"):
		traction.x += 1
	
	traction = traction.normalized()
	
	velocity += traction * acceleration * delta

func frictutate(delta: float):
	velocity -= velocity * friction * delta

func die():
	global_position = spawn_pos
