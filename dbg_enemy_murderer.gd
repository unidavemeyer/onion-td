extends Node2D


func _on_murder_pressed():
	#BB: we may want to iterate over all childen and see which can be murdered
	$Root/Main/Mobs.get_child(1).take_damage(DamageParams.new(1))
