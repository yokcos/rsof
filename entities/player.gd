extends KinematicBody2D


var rotation_speed: float = 30

var velocity: Vector2 = Vector2()
var acceleration: float = 2000
var friction: float = 10

var spawn_pos: Vector2 = Vector2()


func _ready() -> void:
	add_to_group("players")
	spawn_pos = global_position

func _process(delta: float) -> void:
	$triangle.rotation_degrees += rotation_speed * delta
	
	tractutate(delta)
	frictutate(delta)
	
	velocity = move_and_slide(velocity)


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
