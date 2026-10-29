extends Node2D

@onready var mapPacked: PackedScene = preload("res://maps/test_map.tscn")
var map: TileMapLayer

"""Debug function to initialize maps. Can be generalized later."""
func _ready() -> void:
	# Initialize the selected map
	map = mapPacked.instantiate()
	add_child(map)

"""Takes a global position coordinate set (in pixels) and returns the tilemap position of the nearest tile."""
func get_nearest_tile(position: Vector2) -> Vector2i:
	# Converts global to local > local to tilemap coordinates
	return map.local_to_map(map.to_local(position))

"""Returns the global position in pixels of a certain tile on the map."""
func get_pixel_position(tile_position: Vector2i) -> Vector2:
	# Converts tilemap coordinates to local > local to global
	return map.map_to_local(map.to_global(tile_position))
