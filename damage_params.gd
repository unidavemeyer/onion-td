class_name DamageParams
extends RefCounted

#BB: should this be a float?
var hp: int
var effects: Array[String]

func _init(hp: int, effects: Array[String] = []):
	self.hp = hp
	self.effects = effects
