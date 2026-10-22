extends Node2D


func _on_murder_pressed():
	#BB: we may want to iterate over all childen and see which can be murdered
	get_child(0).take_damage(DamageParams.new(1))
