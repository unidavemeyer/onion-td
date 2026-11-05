class_name Enemy

extends CharacterBody2D

#Health vars
var max_hp: int
#BB: should this be a float?
var hp: int
var death_time: float = 1

#Navigation vars
var speed: int
var path: PackedVector2Array
var moving: bool = false
#Uses ciel to ensure that it's not too small
var reach_deadband: int = 5
var target: Vector2i
var direction: Vector2

#Collision_shape vars
var collision_shape: CollisionShape2D
#BB: units unkown (not in docs), probably pixels 
var radius: int
var shape: CircleShape2D

#Sprite vars
var sprite: AnimatedSprite2D
var frames: SpriteFrames

var path_age_ms: float = 0

func _init():
	#print("enemy_init ran! Whoohoo!")
	var_setup()
	collision_shape_setup()
	sprite_setup()
	
func _ready():
	update_path()

#BB: we might want to refactor this later
func _physics_process(_delta: float):
	if Constants.navigation_grid.last_updated_at > path_age_ms:
		update_path()
	
	if target != null and moving:	
		direction = global_position.direction_to(target)
		
		velocity = direction * speed
		move_and_slide()
		
		if global_position.distance_to(target) <= reach_deadband:
			moving = false
		
	elif path != null and len(path) > 0:
		#Sees if the target we just reached is on the path
		if Vector2i(path[0]) == target:
			path.remove_at(0)
		#Sees if there's another target to reach
		if len(path) > 0:
			target = path[0]
			#print(target)
			moving = true

func collision_shape_setup():
	shape = CircleShape2D.new()
	shape.set_radius(radius)
	collision_shape = CollisionShape2D.new()
	collision_shape.shape = shape
	add_child(collision_shape)
	# Sets it as being detectable by towers
	set_collision_layer_value(Constants.enemy_collision_layer, true)
	# Makes sure enemies don't bump
	set_collision_mask_value(1, false)

func sprite_setup():
	sprite = AnimatedSprite2D.new()
	sprite.set_sprite_frames(frames)
	#BB: we're not sure we need pause, but it should prevent animations
	sprite.pause()
	sprite.set_animation("idle")
	add_child(sprite)

func var_setup():
	#Anyone who inherets this should define vars in it
	#BB: can we make it so you're required to have these?
	#BB: should hp automatically be set equal to max_hp?
	pass

func take_damage(damage: DamageParams):
	hp -= damage.hp
	if hp <= 0:
		die()

func die():
	collision_shape.queue_free()
	sprite.set_animation("death")
	#BB: can we just stop physics updates?
	#Now it stops once it dies
	moving = false
	path = []
	await get_tree().create_timer(death_time).timeout
	queue_free()

func update_path():
	var nav_grid: NavGrid = Constants.navigation_grid
	if nav_grid.is_ready:
		path = nav_grid.get_point_path()
		#print("We have a path! It's", path)
	else:
		await get_tree().create_timer(0.1).timeout
		update_path()
	path_age_ms = Time.get_ticks_msec()
