extends Node2D


@onready var projectiles: Node2D = $Projectiles
@onready var player: CharacterBody2D = $Player
@onready var bullet_manager: Node2D = $BulletManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func _on_player_spell(pos: Variant, direction: Variant, type: Variant) -> void:
	create_spell(pos, direction, type)


func create_spell(pos, direction, type):
	if type == 'fireball':
		spell_scene = preload("res://scenes/spells/fireball.tscn")
	elif type == 'frostbolt':
		spell_scene = preload("res://scenes/spells/frostbolt.tscn")
	var spell = spell_scene.instantiate() as Area2D
	spell.position = pos
	spell.rotation_degrees = rad_to_deg(direction.angle())
	spell.direction = direction
	projectiles.add_child(spell)

