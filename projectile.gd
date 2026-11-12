class_name Projectile
extends CharacterBody2D

"""How long should the projectile be in the air?"""
var flight_duration: float

"""The position offset of where the projectile spawned relative to its parent tower."""
var position_offset: Vector2

"""Target position to fly at"""
var target_position: Vector2
var relative_target_position: Vector2

"""Damage params for when it hits"""
var damage_params: DamageParams

"""The Sprite2D for the projectile"""
var sprite: Sprite2D

"""The Area2D for the projectile"""
var area: Area2D

"""How fast the projectile spins"""
var rotation_speed: float

"""The x-speed of the projectile in pixels per second."""
var projectile_x_speed: float

# Math stuff
var derivative_y_intercept: float

func _init(damage_params: DamageParams, image: CompressedTexture2D, flight_duration: float, position_offset: Vector2 = Vector2.ZERO, rotation_speed: float = 0) -> void:
	self.damage_params = damage_params
	# This is in degrees, as angles generally are in Godot
	self.rotation_speed = rotation_speed
	# This is in seconds, as time usually is in Godot
	self.flight_duration = flight_duration
	self.position_offset = position_offset
	self.global_position += position_offset
	
	self.sprite = Sprite2D.new()
	sprite.texture = image
	add_child(sprite)
	
	self.area = Area2D.new()
	add_child(area)
	var collision_shape: CollisionShape2D = CollisionShape2D.new()
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = 5
	area.add_child(collision_shape)
	area.set_collision_mask_value(Constants.enemy_collision_layer, true)
	
	area.body_entered.connect(check_target)

func fire_at(target_position: Vector2):
	# This needs to be in world space! If a tower tries to send a target position in local space,
	# it *might* work, just due to the tower's parent node being at (0, 0) anyway, but it's likely to break things.
	# So, uh, don't do that.
	self.target_position = target_position
	self.relative_target_position = target_position - global_position
	self.projectile_x_speed = relative_target_position.x / flight_duration
	
	self.derivative_y_intercept = (relative_target_position.y / relative_target_position.x) - relative_target_position.x

func _physics_process(delta: float) -> void:
	# Parabola shenanigans!
	# Where we are relative to where we spawned. This can't just use local space and be done, since the position offset exists.
	var relative_position = position - position_offset
	# And then we use the derivative of the parabola to get the ideal slope at this x
	var projectile_slope = 2 * relative_position.x + derivative_y_intercept
	self.velocity.x = projectile_x_speed
	self.velocity.y = projectile_slope * projectile_x_speed
	move_and_slide()
	
	# If it's reached the end of the path without hitting an enemy (presumably missed), then delete it
	if global_position.distance_to(target_position) < 1:
		queue_free()
	
	# Spinny!!
	rotation += rotation_speed
	
func check_target(body):
	if body is Enemy:
		body.take_damage(damage_params)
