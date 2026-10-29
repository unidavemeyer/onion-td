class_name Tower
extends StaticBody2D

var collision_shape: CollisionShape2D

"""The shape used by the CollisionShape2D"""
var shape: Shape2D

"""The size of the tower's base"""
var tower_size: Vector2

var sprite: AnimatedSprite2D
var sprite_frames: SpriteFrames

func _init(size = null, sprite_frames = null) -> void:
	# Create the CollisionShape for this tower
	# NOTE: To do so in the editor/scene would mean Tower.new() wouldn't work
	collision_shape = CollisionShape2D.new()
	add_child(collision_shape)
	shape = RectangleShape2D.new()
	collision_shape.shape = shape
	
	# Optional parameters, likely used by super() in child classes for added control over properties
	if size:
		self.tower_size = size
	
	shape.size = tower_size
	
	if sprite_frames:
		sprite = AnimatedSprite2D.new()
		add_child(sprite)
		sprite.sprite_frames = sprite_frames
		# BB: May not be needed; might default to this
		sprite.play("idle")
		# BB: Is this needed? I worry it might unnecessarily loop a single frame otherwise. Could just animate the fire and make it obsolete
		sprite.pause()

func _ready() -> void:
	# Snap to the grid!
	if tower_size == Vector2(32, 32):
		# Make sure a tower is the right size for grid snapping
		# NOTE: Larger towers can have elif statements later, if we make them
		var maps = get_node("/root/Main/Maps")
		var tile_position = maps.get_nearest_tile(global_position)
		global_position = maps.get_pixel_position(tile_position)
		
		# Set the tile as impassable for AStar pathfinding
		Constants.navigation_grid.disable_tile(tile_position)
