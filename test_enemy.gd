class_name Enemy

extends CharacterBody2D

#Health vars
var max_hp: int = 4
#BB: should this be a float?
var hp: int = max_hp
var death_time: float = 1

#Navigation vars
var speed: int = 30
var path: PackedVector2Array
var moving: bool = false
var deadband: int = 15
var target: Vector2i
var direction: Vector2

#Collision_shape vars
var collision_shape: CollisionShape2D
#BB: units unkown (not in docs), probably pixels 
var radius: int = 10
var shape: CircleShape2D

#Sprite vars
var sprite: AnimatedSprite2D
var frames: SpriteFrames = preload("res://assets/evil-and-intimidating-bread-frames.tres")
var sprite_scale: Vector2 = Vector2(4, 4)

func _init():
	#print("enemy_init ran! Whoohoo!")
	
	#Setting up collision_shape so this can be detected
	shape = CircleShape2D.new()
	shape.set_radius(radius)
	collision_shape = CollisionShape2D.new()
	collision_shape.shape = shape
	add_child(collision_shape)
	
	#Setting up the sprite
	sprite = AnimatedSprite2D.new()
	sprite.set_sprite_frames(frames)
	#BB: we're not sure we need pause, but it should prevent animations
	sprite.pause()
	sprite.set_animation("idle")
	sprite.scale = sprite_scale
	add_child(sprite)
	
func _ready():
	update_path()
	
func _physics_process(_delta: float):
	if target != null and moving:	
		direction = global_position.direction_to(target)
		
		velocity = direction * speed
		move_and_slide()
		
		if global_position.distance_to(target) <= deadband:
			moving = false
	else:
		if path != null && len(path)>0:
			var index = path.find(target)
			if index != -1:
				path.remove_at(index)
			if len(path) > 0:
				target=path[0]
				print(target)
				moving = true
			else:
				moving = false
				print("Path Followed!")
	
func take_damage(damage: DamageParams):
	hp -= damage.hp
	if hp <= 0:
		die()

func die():
	collision_shape.queue_free()
	sprite.set_animation("death")
	await get_tree().create_timer(death_time).timeout
	queue_free()

func update_path():
	var nav_grid = $"../NavGrid"
	await nav_grid.ready
	path = nav_grid.get_point_path()
	print("We have a path! It's", path)
