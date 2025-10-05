extends Node2D

func _on_play_pressed() -> void:
	var new = load("res://scenes/menu_level.tscn").instantiate()
	self.get_parent().add_child(new)
	self.queue_free()

func _on_settings_pressed() -> void:
	$settings_popup.visible = true

func _on_button_pressed() -> void:
	$settings_popup.visible = false

func _on_credits_pressed() -> void:
	$credits_popup.visible = true

func _on_button2_pressed() -> void:
	$credits_popup.visible = false
