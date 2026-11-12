class_name WaveGenerator
extends Node2D

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var wave: Array[Enemy] = []
#BB: can we refernce just the classes or just constructers instead of instances?
var enemies: Array[Enemy] = [BreadSlice.new(), FastEnemy.new()]

var spawning_delay: float = 0.5

func _ready():
	rng.set_seed(42)
	generate_wave(13)
	load_wave()

func generate_wave(points: int):
	while points > 0:
		var enemy = enemies[rng.randi_range(0, len(enemies)-1)]
		#BB: if this turns out to be expensive when we have more enemies, perhaps ordering all
			#enemies in terms of value and having it check one earlier in the list upon a fail
			#would be more efficient (or remove the if)
		if enemy.point_cost <= points:
			wave.append(enemy.duplicate())
			points -= enemy.point_cost
			
func load_wave():
	for enemy in wave:
		get_parent().add_child(enemy)
		await get_tree().create_timer(0.5).timeout
