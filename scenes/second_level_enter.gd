extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_entered(body: Node2D) -> void:
	print("Body entered:", body.name)
	if body.is_in_group("player"):  # Assuming the player is in a group called "player"
		print("is player going up")
		body.z_index = 7  # Set z_index to 7
		var collision_layer = body.collision_mask
		print(collision_layer)
		body.collision_mask = (body.collision_mask & ~((1 << 1) | (1 << 2))) | (1 << 3)
		print(body.collision_mask)
