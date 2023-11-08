class_name HealthUpdate
extends RefCounted

# Public
var previous: float
var current: float
var max_health: float
var percentage: float
var is_healing: bool


func _init(prev: float, curr: float, max_h: float, percen: float, healing: bool):
	self.previous = prev
	self.current = curr
	self.max_health = max_h
	self.percentage = percen
	self.is_healing = healing
