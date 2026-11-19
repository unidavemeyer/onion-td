extends Node2D

func _on_murder_pressed():
	murder(3)

func murder_one():
	#BB: change to murder_all but with break after taking damage?
	$/root/Main/Mobs.get_child(1).take_damage(DamageParams.new(1))

"""If victims is negative, murders all"""
func murder(victims: int):
	var children = $/root/Main/Mobs.get_children()
	
	for child in children:
		if child is Enemy:
			child.take_damage(DamageParams.new(1))
			
			if victims > 0:
				victims -= 1
				if victims == 0:
					break
