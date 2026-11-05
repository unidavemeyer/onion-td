class_name fast_enemy
extends Enemy

func _init():
	self.speed = 50
	self.max_hp = 1
	
	#Running the parent's init
	super()
