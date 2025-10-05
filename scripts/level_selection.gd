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
		i.pressed.connect(start_level.bind(i.name))
	
func start_level(lvl): 
	var gp_scene = load("res://scenes/gameplay_scene.tscn").instantiate()
	gp_scene.lvl = load("res://scenes/levels/level_" + lvl + ".tscn")
	self.get_parent().get_parent().add_child(gp_scene)
	self.get_parent().queue_free()
	
