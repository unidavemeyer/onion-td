class_name Enemy

extends CharacterBody2D

var health = 4

var collision_shape: CollisionShape2D
var size: int = 10
var shape: CircleShape2D

var sprite: AnimatedSprite2D
var frames: SpriteFrames = preload("res://assets/evil-and-intimidating-bread-frames.tres")

func _init():
	print("Init ran! Whoohoo!")
	collision_shape = CollisionShape2D.new()
	shape = CircleShape2D.new()
	shape.set_radius(size)
	collision_shape.shape = shape
	add_child(collision_shape)
	
	sprite=AnimatedSprite2D.new()
	sprite.set_sprite_frames(frames)
	sprite.pause()
	sprite.set_animation("idle")
	sprite.scale = Vector2(4, 4)
	add_child(sprite)
	
func take_damage(damage: DamageParams):
	health-=damage.value
	if health <= 0:
		die()

func die():
	collision_shape.queue_free()
	sprite.set_animation("death")
	await get_tree().create_timer(1).timeout
	queue_free()
