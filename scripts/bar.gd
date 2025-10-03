extends HBoxContainer

@export var lvl_objects = {"blocks": 1, "slope_big": 2, "slope_small": 2, "slope_mid": 2}
var offsets = {"blocks": Vector2(0,0), "slope_big": Vector2(128, 64), "slope_small": Vector2(192, 64), "slope_mid": Vector2(192, 0)}

func _process(delta: float) -> void:
	for i in get_children():
		i.get_node("amount").text = var_to_str(lvl_objects[i.name])
		if lvl_objects[i.name] == 0:
			i.visible = false
		else:
			i.visible = true
		i.get_node("sprite").texture.region = Rect2(offsets[i.name], Vector2(64,64))
