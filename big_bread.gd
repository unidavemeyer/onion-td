class_name BigBread
extends Enemy

func var_setup():
	self.speed = 15
	self.max_hp = 6
	self.hp = max_hp
	self.radius = 10
	self.frames = preload("res://assets/big_bread.tres")
	self.point_cost = 1
	print("Big Bread!")

func die():
	if alive:
		alive = false
		collision_shape.queue_free()
		sprite.set_animation("death")
		
		for i in range(0,3):
			var slice = BreadSlice.new()
			get_parent().add_child(slice)
			slice.global_position = Vector2(global_position.x + 10 * (i - 1), global_position.y)
			slice.path = path
		
		moving = false
		path = []
		await get_tree().create_timer(death_time).timeout		
		queue_free()
	
