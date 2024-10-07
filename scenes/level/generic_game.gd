extends Node2D
class_name GameParent

@onready var projectiles: Node2D = $Projectiles
@onready var player: CharacterBody2D = $Player
@onready var game_scene: PackedScene = preload("res://scenes/level/game.tscn") as PackedScene

var spell_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	
