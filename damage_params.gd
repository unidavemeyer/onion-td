class_name DamageParams
extends Node

var value: int
var effects: Array[String]

func _init(value: int, effects: Array[String] = []):
	self.value = value
	self.effects = effects
