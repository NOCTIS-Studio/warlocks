extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var bullet_manager: Node2D = $BulletManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_stairs_down_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
