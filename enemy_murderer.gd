extends Node2D



func _on_murder_pressed():
	get_child(0).take_damage(DamageParams.new(1))
