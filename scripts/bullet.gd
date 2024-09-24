extends Area2D

const SPEED = 5
var direction := Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * SPEED
		global_position += velocity

func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()

func deal_damage():
	pass
