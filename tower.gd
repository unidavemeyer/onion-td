class_name Tower
extends StaticBody2D

var collision_shape: CollisionShape2D
"""The shape used by the CollisionShape2D"""
var shape: Shape2D
"""The scale of the tower. This is a flat multiplier, 4x matches the current scale for enemies"""
# NOTE: We don't want to expose this to the init / allow towers to change their multiplier, because mixels suck
# BB: This is meant to match the scale for units, but perhaps we ought to use a camera and zoom instead, or have one global constant attached to Main
var tower_scale: Vector2 = Vector2(4, 4)

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
		shape.size = size
	if sprite_frames:
		sprite = AnimatedSprite2D.new()
		add_child(sprite)
		sprite.sprite_frames = sprite_frames
		# BB: May not be needed; might default to this
		sprite.play("idle")
		# BB: Is this needed? I worry it might unnecessarily loop a single frame otherwise. Could just animate the fire and make it obsolete
		sprite.pause()
	
	# Finally, scale everything properly
	scale = tower_scale
