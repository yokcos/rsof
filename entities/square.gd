extends Area2D


var rotation_speed: float = -290
var freeze_time: float = 0
var freeze_stats: Transform2D = Transform2D()


func _ready() -> void:
	add_to_group("squares")

func _process(delta: float) -> void:
	$polygon.rotation_degrees += rotation_speed * delta
	
	if freeze_time > 0:
		freeze_time -= delta
		global_transform = freeze_stats
		if freeze_time <= 0:
			get_unfrozen()


func get_frozen():
	freeze_stats = get_global_transform()
	rotation_speed = 0

func get_unfrozen():
	rotation_speed = -290


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		body.die()
