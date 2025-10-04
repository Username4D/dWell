extends Node2D

@export var spawnpos = Vector2(416, 32)
@export var possible_placements = []

func _ready() -> void:
	for i in $possible_placements.get_children():
		possible_placements.append(i.position)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start"):
		if $coin.freeze:
			$coin.freeze = false
		else:

			$coin.linear_velocity = Vector2.ZERO
			$coin.angular_velocity = 0
			PhysicsServer2D.body_set_state(
			$coin.get_rid(),
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			Transform2D.IDENTITY.translated(spawnpos)
			)
			await get_tree().physics_frame
			$coin.freeze = true
