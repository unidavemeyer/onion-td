class_name SoupTower
extends Tower

"""The scale of the CollisionShape in pixels"""
# NOTE: Automatically gets scaled up to match the visual pixel scale
var object_size: Vector2 = Vector2(32, 32)
"""The offset of the sprite relative to the hitbox, in pixels"""
# NOTE: ALSO automatically scaled up to visual pixels, see comment below when utilizing this variable
# NOTE: Negative y is up, which is what we need
var sprite_offset: Vector2 = Vector2(0, -12)
"""The effect radius of the tower. This tower is AOE, meaning everyone in the area is damaged"""
# BB: This is theoretically in pixels, but it's important to note that it's scaled-up pixels
# BB: This therefore matches the visual pixel scale but not Godot's internal idea of position etc in pixels (I will refer to these units as visual pixels)
# BB: I'd change that now, but I don't want to drag in mostly-unrelated changes into the Tower PR. Plus, we'll have to add a camera later.
# NOTE: 48 visual pixels is 32 visual pixels beyond the tower's boundaries. 32 visual pixels is one tile radius. I think that's sensible for an AOE tower, but we can change that later
var attack_radius: int = 48
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
# BB: It's an AOE tower, so a long cooldown makes sense, but this may be excessive. Needs balance testing, but that's a later issue
var attack_cooldown: int = 3
"""The DamageParams object we pass to enemies damaged by the tower"""
# BB: It has a slow enough cooldown that it should do a good amount of damage. Left it at 2 so that the debug scene can have the tower attack twice, but we should change this later.
var damage_params: DamageParams = DamageParams.new(2)
"""False if the attack is on cooldown"""
var attack_ready: bool = true

func _init() -> void:
	# Creates a Tower with the specific SpriteFrames and size of the tower.
	# NOTE: Tower size ought to be standard at 32 visual pixels, but I made it an argument just to be safe
	sprite_frames = preload("res://assets/soup_tower.tres")
	super(object_size, sprite_frames)
	
	# NOTE: the sprite_offset does not need to be scaled, using position instead of global_position means it happens automatically
	sprite.position += sprite_offset
	
	# Creates the attack range of the tower as an Area2D so that we can check for units inside it. This is weirdly complicated to set up for some reason.
	attack_area = Area2D.new()
	add_child(attack_area)
	# BB: It needs a CollisionShape to define its area. This seems odd. Will this cause issues with ghost collisions? Or is it just so that we can select collision layers and select what trips the Area2D?
	attack_area_collision = CollisionShape2D.new()
	attack_area.add_child(attack_area_collision)
	attack_area_shape = CircleShape2D.new()
	attack_area_collision.shape = attack_area_shape
	# BB: In the Enemy class, we use set_radius(). I don't know if there's a reason to do that rather than setting the value directly. There might be.
	attack_area_shape.radius = attack_radius
	# NOTE: This essentially tells the attack area to only detect bodies that have collision layer 2 enabled, which means it catches enemies and not other towers (or itself)
	attack_area.set_collision_mask_value(2, true)
	attack_area.set_collision_mask_value(1, false)
	
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
			if not target.is_in_group("enemy"):
				possible_targets.erase(target)
		
		# Don't bother attacking if there are no targets
		if len(possible_targets) < 1:
			return
		else:
			attack(possible_targets)

"""Attack all enemies within range, dealing damage based on damage_params"""
func attack(targets: Array):
	# Rearm the cooldown timer and mark the attack as on cooldown
	attack_timer.start()
	attack_ready = false
	
	# Deal the damage
	for target in targets:
		target.take_damage(damage_params)
	
	# Play the attack animation for one second, then return to idle
	# BB: Later, when I have a real animation, we can use signals from the AnimatedSprite for when the animation finishes
	sprite.play("attack")
	await get_tree().create_timer(1).timeout
	sprite.play("idle")
	
