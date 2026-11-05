class_name PepperTower
extends Tower

"""The offset of the sprite relative to the hitbox, in pixels"""
# NOTE: Negative y is up, which is what we need
var sprite_offset: Vector2 = Vector2(0, -12)

"""The effect radius of the tower, in pixels."""
var attack_radius: int = 80

"""The Area2D representing the attack area of the tower. Uses attack_radius as its radius."""
var attack_area: Area2D

"""The CollisionShape2D representing the area for the Area2D."""
# BB: the sheer number of objects I'm declaring as variables here is insane. This is for consistency with the Tower and Enemy classes, but we should consider whether we need all of them defined as class-wide variables
var attack_area_collision: CollisionShape2D

"""The Shape2D representing the attack_area."""
var attack_area_shape: Shape2D

"""The Timer representing the attack cooldown of the tower."""
var attack_timer: Timer

"""How long the cooldown between attacks should be, in seconds"""
# BB: Needs balance testing, but that's a later issue
var attack_cooldown: int = 3

"""The DamageParams object we pass to enemies damaged by the tower"""
var damage_params: DamageParams = DamageParams.new(1)

"""False if the attack is on cooldown"""
var attack_ready: bool = true

"""The image for the projectile"""
var projectile_image: CompressedTexture2D = preload("res://assets/pepper.png")

func _init() -> void:
	# Creates a Tower with the specific SpriteFrames.
	sprite_frames = preload("res://assets/pepper_ness_of_doom_and_despair.tres")
	super(sprite_frames)
	
	sprite.position += sprite_offset
	
	# Creates the attack range of the tower as an Area2D so that we can check for units inside it. This is weirdly complicated to set up for some reason.
	attack_area = Area2D.new()
	add_child(attack_area)
	# BB: It needs a CollisionShape to define its area. This seems odd. Will this cause issues with ghost collisions? Or is it just so that we can select collision layers and select what trips the Area2D?
	attack_area_collision = CollisionShape2D.new()
	attack_area.add_child(attack_area_collision)
	attack_area_shape = CircleShape2D.new()
	attack_area_collision.shape = attack_area_shape
	attack_area_shape.set_radius(attack_radius)
	# NOTE: This essentially tells the attack area to only detect bodies that have collision layer 2 enabled, which means it catches enemies and not other towers (or itself)
	attack_area.set_collision_mask_value(Constants.enemy_collision_layer, true)
	attack_area.set_collision_mask_value(Constants.ground_collision_layer, false)
	
	# Finally, set up the attack timer
	attack_timer = Timer.new()
	attack_timer.wait_time = attack_cooldown
	# BB: The timer defaults to autostart = true, I believe. If I'm wrong, then this is unnecessary
	attack_timer.stop()
	add_child(attack_timer)
	# Resets the attack cooldown whenever the timer finishes
	attack_timer.timeout.connect(_on_attack_cooldown_reset)
	# The timer shouldn't automatically restart when it runs out. We should manually re-arm it when we attack
	attack_timer.one_shot = true

func _on_attack_cooldown_reset():
	attack_ready = true

func _process(delta: float) -> void:
	# Checks if the attack is ready or not, and if so, checks for targets to use it on
	if attack_ready:
		var possible_targets = attack_area.get_overlapping_bodies()
		for target in possible_targets:
			# We only care about enemies for the purposes of targeting
			if not target is Enemy:
				possible_targets.erase(target)
		
		# Don't bother attacking if there are no targets
		if len(possible_targets) < 1:
			return
		else:
			# Attack a random target within range -- I think this is fun and flavorful for a pepper shaker
			attack(possible_targets[0])

"""Attack an enemy, dealing damage based on damage_params"""
func attack(target: Enemy):
	# Rearm the cooldown timer and mark the attack as on cooldown
	attack_timer.start()
	attack_ready = false
	
	# Fire the projectile
	var projectile = Projectile.new(target, damage_params, projectile_image, Vector2(0, -32))
	add_child(projectile)
	
	# Play the attack animation for one second, then return to idle
	# BB: Later, when I have a real animation, we can use signals from the AnimatedSprite for when the animation finishes
	sprite.play("attack")
	await get_tree().create_timer(1).timeout
	sprite.play("idle")
	
