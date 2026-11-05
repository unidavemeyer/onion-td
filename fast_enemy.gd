class_name fast_enemy
extends Enemy

func _init():
	self.speed = 50
	self.max_hp = 1
	self.radius = 6
	self.frames = preload("res://assets/test_cookie.tres")
	
	#Running the parent's init
	super()
