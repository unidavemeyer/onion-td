extends Node2D

func _ready() -> void:
	# Creates a soup tower
	add_child(SoupTower.new())
	get_child(0).global_position += Vector2(400, 300)
