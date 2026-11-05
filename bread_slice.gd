class_name bread_slice
extends Enemy

func _init():
	self.speed = 30
	self.max_hp = 4
	self.radius = 10
	self.frames = preload("res://assets/evil-and-intimidating-bread-frames.tres")
	
	#Running the parent's init
	super()
