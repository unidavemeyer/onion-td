class_name NavGrid
extends RefCounted

var is_ready: bool = false

var cell_size: Vector2i = Vector2i(32, 32)
var astar_grid: AStarGrid2D = AStarGrid2D.new()
var grid_size: Vector2i

var path_start_cell: Vector2i = Vector2i(0, 0)
var path_end_cell: Vector2i = Vector2i(5,6)

var path: PackedVector2Array
var last_updated_at: float = 0

func _init():
	setup()
	
func setup(grid_size: Vector2i = Vector2i(10, 10)):
	is_ready = false
	#Creates the grid
	@warning_ignore("integer_division")
	self.grid_size = grid_size
	astar_grid.size = grid_size
	astar_grid.cell_size = cell_size
	
	#Makes the pathfinding target the center of each square
	@warning_ignore("integer_division")
	astar_grid.offset = cell_size / 2
	
	#Allows it to move diagonally unless it is blocked by two towers
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	#NOTE: AStarGrid2D.update() resets all tile data, and thus we don't need to reset tiles
	astar_grid.update()
	
	#print("Ready!")
	update_path()
	is_ready = true

func set_grid_size(grid_size: Vector2i):
	is_ready = false
	self.grid_size = grid_size
	astar_grid.size = grid_size
	#BB: this will reset all tile data, including impassability. Make sure to do this BEFORE constructing towers
	astar_grid.update()
	update_path()
	is_ready = true

func update_path():
	#BB: could/should this be async?
	path = astar_grid.get_point_path(path_start_cell, path_end_cell)
	last_updated_at = Time.get_ticks_msec()
	#print(path)
	
func get_point_path():
	#BB: should we have a less expensive option?
	print(path)
	return path.duplicate()

func disable_tile(tile_position: Vector2i):
	# NOTE: Solid = true means non-navigable
	# NOTE: We don't want to run update() since that resets tile data
	astar_grid.set_point_solid(tile_position, true)
	update_path()

func enable_tile(tile_position: Vector2i):
	# NOTE: Solid = true means non-navigable
	# NOTE: We don't want to run update() since that resets tile data
	astar_grid.set_point_solid(tile_position, false)
	update_path()
