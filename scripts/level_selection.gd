extends HBoxContainer

var max_level = 7
var stars = []
func _ready() -> void:
	var file = FileAccess.open("user://levels.dat", FileAccess.READ)
	if file == null:
		file = FileAccess.open("user://levels.dat", FileAccess.WRITE)
		file.store_var([0,0,0,0,0,0,0,0])
		stars = [false,false,false,false,false,false,false,false]
		max_level = 0
	else:
		
		var array = file.get_var()
		print(array)
		for i in array:
			if i == 2:
				stars.append(true)
			else:
				stars.append(false)
		max_level = array.find(0)
		print(max_level)
	for i in get_children():
		i.get_node("label").text = i.name
		if int(i.name) -1 > max_level:
			i.get_node("label").visible = false
			i.self_modulate.a = 0.5
		else:
			i.pressed.connect(start_level.bind(i.name))
		if stars[int(i.name) -1 ]:
			i.get_node("star").visible = true
	
	
func start_level(lvl): 
	var gp_scene = load("res://scenes/gameplay_scene.tscn").instantiate()
	gp_scene.lvl = load("res://scenes/levels/level_" + lvl + ".tscn")
	self.get_parent().get_parent().add_child(gp_scene)
	self.get_parent().queue_free()
	gp_scene.num = lvl

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		self.get_parent().get_parent().add_child(load("res://scenes/d_well.tscn").instantiate())
		self.get_parent().queue_free()
