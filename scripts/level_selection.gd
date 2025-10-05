extends HBoxContainer

var max_level = 7
var stars = [true,false,true,true,false,false,true,true]
func _ready() -> void:
	for i in get_children():
		i.get_node("label").text = i.name
		if int(i.name) -1 > max_level:
			i.get_node("label").visible = false
			i.self_modulate.a = 0.5
		if stars[int(i.name) -1 ]:
			i.get_node("star").visible = false
	
