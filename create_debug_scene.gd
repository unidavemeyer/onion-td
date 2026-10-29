extends Node2D

func _ready() -> void:
	#NOTE: Made sure the map is set up first, otherwise the tower would build but tile impassability would get reset
	while not $Maps.is_ready:
		await get_tree().create_timer(0.1).timeout
	
	# Creates a soup tower
	var dbg_tower: SoupTower = SoupTower.new()
	$Towers.add_child(dbg_tower)
	dbg_tower.global_position = $Maps.get_pixel_position(Vector2i(5, 5))
	
	# Creates a basic enemy
	var dbg_enemy: Enemy = Enemy.new()
	$Mobs.add_child(dbg_enemy)
	dbg_enemy.global_position = $Maps.get_pixel_position(Vector2i(0, 0))
