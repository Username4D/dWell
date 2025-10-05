extends HBoxContainer

@export var lvl_objects = {"blocks": 1, "slope_big": 2, "slope_small": 2, "slope_mid": 2}
var offsets = {"blocks": Vector2(0,0), "slope_big": Vector2(128, 64), "slope_small": Vector2(192, 64), "slope_mid": Vector2(192, 0)}
var object_scene = preload("res://scenes/object.tscn")
var disabled = false

func _process(delta: float) -> void:
	for i in get_children():
		i.get_node("amount").text = var_to_str(lvl_objects[i.name])
		if lvl_objects[i.name] == 0:
			i.visible = false
		else:
			i.visible = true
		i.get_node("sprite").texture.region = Rect2(offsets[i.name], Vector2(64,64))

func _ready() -> void:
	for i in get_children():
		i.pressed.connect(create.bind(i))
	
func create(i:Node) -> void:
	if lvl_objects[i.name] > 0 and not disabled:
		var object = object_scene.instantiate()
		object.bpressed = true
		object.oname = i.name
		object.pressed.emit()
		object.get_node("sprite").texture.region = Rect2(offsets[i.name], Vector2(64,64))
		$"../objects".add_child(object)
		await i.button_up
		object._released()
		lvl_objects[i.name] -= 1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start") and self.get_parent().can_start:
		disabled = false if disabled else true
		self.visible = not disabled

func change():
	disabled = false if disabled else true
	self.visible = not disabled
