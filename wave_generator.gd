class_name Wave_Generator
extends Node2D

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var wave: Array[Enemy] = []
var enemies: Array[Enemy] = [BreadSlice.new(), FastEnemy.new()]

func _ready():
	rng.set_seed(42)
	generate_wave()
	load_wave()

func generate_wave():
	for i in range(0,5):
		wave.append(enemies[rng.randi_range(0,1)].duplicate())
	print(wave)

func load_wave():
	for enemy in wave:
		get_parent().add_child(enemy)
		await get_tree().create_timer(0.5).timeout
