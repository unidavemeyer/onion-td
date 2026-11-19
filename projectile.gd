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
var arc_coefficient: float

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
	# BB: Seems a little odd to have a sprite and a radius that are disconnected.
	# We may want to consider child classes for the different projectile types, which would eliminate a lot of the params as well.
	# BB: This is really rather large. Tweak later?
	collision_shape.shape.radius = 5
	# BB: Should we have this always active? Tentative yes, in case we make projectiles with no specific target.
	area.add_child(collision_shape)
	area.set_collision_mask_value(Constants.enemy_collision_layer, true)
	
	area.body_entered.connect(check_target)

func _ready() -> void:
	# Remove the projectile after its lifetime has expired
	# NOTE: Needs to be done in _ready, since _init doesn't require the scene tree to exist yet
	await get_tree().create_timer(self.flight_duration).timeout
	queue_free()

func fire_at(target_position: Vector2):
	# This needs to be in world space! If a tower tries to send a target position in local space,
	# it *might* work, just due to the tower's parent node being at (0, 0) anyway, but it's likely to break things.
	# So, uh, don't do that.
	
	# What we're essentially doing here is we're getting the y-intercept of the derivative of the intended parabola to use for the arc,
	# which is how vertically the initial projectile fires. We're also getting an arc coefficient to flatten the arc and make
	# sure it doesn't fly off into the sky.
	self.target_position = target_position
	self.relative_target_position = target_position - global_position
	# Arc coefficient is used to flatten the arc.
	var arc_numerator = 5
	self.arc_coefficient = arc_numerator/(abs(relative_target_position.x) + abs(relative_target_position).y)
	
	# Dang zero division crashed my computer
	if relative_target_position.x == 0:
		relative_target_position.x = 0.0001
	
	# We track speed in regards to the x-axis to more closely mirror the graph of the parabola we want.
	# We can therefore easily calculate the slope of the parabola at the point since we're tracking x-position
	# and not position along a 2D vector.
	self.projectile_x_speed = relative_target_position.x / flight_duration
	self.derivative_y_intercept = (relative_target_position.y / relative_target_position.x) - relative_target_position.x * arc_coefficient

func _physics_process(delta: float) -> void:
	# Parabola shenanigans!
	# Where we are relative to where we spawned. This can't just use local space and be done, since the position offset exists.
	var relative_position = position - position_offset
	# And then we use the derivative of the parabola to get the ideal slope at this x. The 2 here is because 2x is the
	# derivative of x^2. All of our calculations here are in "slope space", using the derivative of the parabola
	# to figure out the angle we should be moving at each point. The arc coefficient here is likely a really low
	# number, which means that the arc should be flattened and not go off to infinity.
	var projectile_slope = 2 * arc_coefficient * relative_position.x + derivative_y_intercept
	self.velocity.x = projectile_x_speed
	# We then use the slope and turn it into the y-velocity by scaling it to how fast we're moving in the x-axis.
	self.velocity.y = projectile_slope * projectile_x_speed
	move_and_slide()
	
	# Spinny!!
	rotation += rotation_speed * delta

func check_target(body):
	if body is Enemy:
		body.take_damage(damage_params)
		queue_free()
