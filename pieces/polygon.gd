extends Polygon2D


export (float) var radius = 32
export (int) var vertices = 4


func _ready() -> void:
	var points: Array = []
	
	for i in range(vertices):
		points.append(Vector2(radius, 0).rotated(PI*2*i/vertices))
	
	polygon = PoolVector2Array(points)
