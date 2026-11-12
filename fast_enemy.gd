class_name FastEnemy
extends Enemy

func var_setup():
	self.speed = 50
	self.max_hp = 1
	self.hp = max_hp
	self.radius = 6
	self.frames = preload("res://assets/test_cookie.tres")
