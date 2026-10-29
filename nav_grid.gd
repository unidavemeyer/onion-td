extends Node2D

var cell_scalar: int = 4
var cell_size: Vector2i = Vector2i(32 * cell_scalar, 32 * cell_scalar)
var astar_grid: AStarGrid2D = AStarGrid2D.new()
var grid_size: Vector2i

var path_start: Vector2i = Vector2i.ZERO
var path_end: Vector2i = Vector2i(8,4)

var path: PackedVector2Array

func _ready():
	setup()
	
func setup():
	#Creates the grid
	@warning_ignore("integer_division")
	grid_size = Vector2i(get_viewport_rect().size) / cell_size
	astar_grid.size = grid_size
	astar_grid.cell_size = cell_size
	#Makes the pathfinding target the center of each square
	@warning_ignore("integer_division")
	astar_grid.offset = cell_size / 2
	#Allows it to move diagonally unless it is blocked by two towers
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	astar_grid.update()
	#print("Ready!")
	update_path()

func update_path():
	#BB: could/should this be async?
	path = astar_grid.get_point_path(path_start, path_end)
	#print(path)
	
func get_point_path():
	#BB: should we have a less expensive option?
	return path.duplicate()
