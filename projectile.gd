class_name Projectile
extends CharacterBody2D

"""Projectile speed in pixels / sec"""
var projectile_speed: float

"""Direction of the last segment of the arc in degrees"""
var current_direction: Vector2

"""Enemy that's being fired at"""
var target: Enemy

"""Damage params for when it hits"""
var damage_params: DamageParams

"""The Sprite2D for the projectile"""
var sprite: Sprite2D

"""The upward velocity for the arc. Initial defined value is the starting velocity"""
var upward_velocity: float

"""The decay on the upward velocity for the arc, subtracted each physics_process"""
var upward_velocity_decay: float

"""How fast the projectile spins"""
var rotation_speed: float

func _init(target: Enemy, damage_params: DamageParams, image: CompressedTexture2D, start_position_offset: Vector2, projectile_speed: float = 100, rotation_speed: float = 1, firing_direction: Vector2 = Vector2(0, -1), upwards_starting_velocity: float = -200) -> void:
	self.projectile_speed = projectile_speed
	self.current_direction = firing_direction
	self.target = target
	self.damage_params = damage_params
	self.rotation_speed = rotation_speed
	
	self.upward_velocity = upwards_starting_velocity
	self.upward_velocity_decay = -upward_velocity * 0.05
	
	self.position = start_position_offset
	
	self.sprite = Sprite2D.new()
	sprite.texture = image
	add_child(sprite)

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		queue_free()
		return
	
	if self.global_position.distance_to(target.global_position) <= target.radius:
		target.take_damage(damage_params)
		queue_free()
		return
	
	var target_direction = self.global_position.direction_to(target.global_position)
	
	current_direction = lerp(current_direction, target_direction, 0.2).normalized()
	velocity = current_direction * projectile_speed
	# NOTE: This is to adjust for the fact that we have a decaying upwards arc and thus we'd otherwise undershoot
	velocity.x *= 1.2
	# Decay the upward velocity to make an arc
	velocity.y = upward_velocity 
	upward_velocity += upward_velocity_decay
	move_and_slide()
	
	# Spinny!!
	rotation += rotation_speed
