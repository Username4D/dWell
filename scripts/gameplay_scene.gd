extends Node2D

@export var spawnpos = Vector2(416, 32)
@export var possible_placements = []
@export var stars = 0
@export var lvl = preload("res://scenes/levels/level_1.tscn")
enum TileTransform {
	R0 = 0,
	R90 = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_H,
	R180 = TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_FLIP_V,
	R270 = TileSetAtlasSource.TRANSFORM_TRANSPOSE | TileSetAtlasSource.TRANSFORM_FLIP_V,
}

func _ready() -> void:
	var import_lvl = lvl.instantiate()
	var header = import_lvl.get_node("header")
	$bar.lvl_objects = header.items 
	spawnpos = header.spawnpos
	header.queue_free()
	for i in import_lvl.get_children():
		i.reparent(self)
	for i in $possible_placements.get_children():
		possible_placements.append(i.position)
	var dict = {"borders": $tilemap_bg.get_used_cells(), "borders_id": $tilemap_bg.get_used_cells_by_id()}
	PhysicsServer2D.body_set_state($coin.get_rid(),PhysicsServer2D.BODY_STATE_TRANSFORM,Transform2D.IDENTITY.translated(spawnpos))
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start"):
		if $coin.freeze:
			$tilemap_objects.clear()
			$tilemap_objects.visible = true
			$objects.visible = false
			$coin.freeze = false
			for i in $objects.get_children():
				$tilemap_objects.set_cell(Vector2i(i.position) / 64, 0, i.get_node("sprite").texture.region.position / 64, TileTransform["R"+var_to_str(int(i.rotation_degrees))])
				print(i.get_node("sprite").texture.region.position / 64)
			print($tilemap_objects.get_used_cells())
		else:
			$tilemap_objects.clear()
			$tilemap_objects.visible = false
			$objects.visible = true
			$coin.linear_velocity = Vector2.ZERO
			$coin.angular_velocity = 0
			await get_tree().physics_frame
			PhysicsServer2D.body_set_state(
			$coin.get_rid(),
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			Transform2D.IDENTITY.translated(spawnpos)
			)
			await get_tree().physics_frame
			$coin.freeze = true
			stars = 0
func finish() -> void:
	print("Finished")
