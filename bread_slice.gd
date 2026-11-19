class_name BreadSlice
extends Enemy

func var_setup():
	self.speed = 30
	self.max_hp = 4
	self.hp = max_hp
	self.radius = 10
	self.frames = preload("res://assets/evil_and_intimidating_bread.tres")
	self.point_cost = 1
