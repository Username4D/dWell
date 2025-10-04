extends Node2D

@export var possible_placements = []

func _ready() -> void:
	for i in $possible_placements.get_children():
		possible_placements.append(i.position)
