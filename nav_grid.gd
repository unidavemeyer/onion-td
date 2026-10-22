extends Node2D

var cell_scalar: int = 4
var cell_size: Vector2i = Vector2i(32 * cell_scalar, 32 * cell_scalar)
var astar_grid: AStarGrid2D = AStarGrid2D.new()
var grid_size: Vector2i

var start: Vector2i = Vector2i.ZERO
var end: Vector2i = Vector2i(5,8)

var path: PackedVector2Array

func _ready():
	grid_size = Vector2i(get_viewport_rect().size) / cell_size
	astar_grid.size = grid_size
	astar_grid.cell_size = cell_size
	astar_grid.offset = cell_size / 2
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	astar_grid.update()
	print("Ready!")
	update_path()
	
func update_path():
	path = PackedVector2Array(astar_grid.get_point_path(start, end))
	print(path)
