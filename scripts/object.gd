extends Button
@export var oname = ""
var bpressed = false
func _pressed() -> void:
	bpressed = true
func _released() -> void:
	bpressed = false
	if not self.get_parent().get_parent().possible_placements.find(gridlock(get_viewport().get_mouse_position()) - Vector2(32, 32)) != -1:
		self.get_parent().get_parent().get_node("bar").lvl_objects[oname] += 1
		self.queue_free()
	for i in self.get_parent().get_children():
		if i.position == self.position and i != self:
			self.get_parent().get_parent().get_node("bar").lvl_objects[i.oname] += 1
			i.queue_free()
func _process(delta: float) -> void:
	if bpressed and self.get_parent().get_parent().possible_placements.find(gridlock(get_viewport().get_mouse_position()) - Vector2(32, 32)) != -1:
		self.position = gridlock(get_viewport().get_mouse_position()) - Vector2(32, 32)
		self.scale = Vector2.ONE
	elif bpressed:
		self.scale = Vector2(.7, .7)
		self.position = get_viewport().get_mouse_position() - Vector2(32,32)
func gridlock(pos: Vector2) -> Vector2:
	return round((pos -Vector2(32,32)) / 64) * 64 + Vector2(32,32)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("rotate") and bpressed:
		self.rotation_degrees += 90
