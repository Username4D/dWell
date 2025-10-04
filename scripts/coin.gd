extends RigidBody2D

@onready var ideal_gravity = 0

func _physics_process(delta: float) -> void:
	ideal_gravity = clamp(1 + linear_velocity.y / 500, 0.2, 3)
	self.gravity_scale = move_toward(self.gravity_scale, ideal_gravity, 0.08)
	#self.mass = 1 + linear_velocity.y / 30

	
