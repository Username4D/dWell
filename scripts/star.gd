extends Area2D

var collected

func _on_body_entered(body: Node2D) -> void:
	self.get_parent().stars += 1
	collected = true
	
func _process(delta: float) -> void:
	if collected:
		$Sprite2D.modulate.v = move_toward($Sprite2D.modulate.v, 1, 10)
	else:
		$Sprite2D.modulate.v = move_toward($Sprite2D.modulate.v, (1 / 255) * 35, 10)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start"):
		collected = false
