class_name bread_slice
extends Enemy

func var_setup():
	self.speed = 30
	self.max_hp = 4
	self.hp = max_hp
	self.radius = 10
	self.frames = preload("res://assets/evil-and-intimidating-bread-frames.tres")
