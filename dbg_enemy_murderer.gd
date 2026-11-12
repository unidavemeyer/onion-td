extends Node2D

func _on_murder_pressed():
	murder_all()

func murder_one():
	$/root/Main/Mobs.get_child(1).take_damage(DamageParams.new(1))
	
func murder_all():
	var children = $/root/Main/Mobs.get_children()
	for child in children:
		if child is Enemy:
			child.take_damage(DamageParams.new(1))
