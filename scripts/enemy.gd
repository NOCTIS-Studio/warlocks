extends CharacterBody2D


var speed = 50
var heatlh = 100
var attackDmg = 5
var dead = false
var takingDmg = false
var player_in_area = false
var player

func _ready() -> void:
	dead = false
	

func _physics_process(delta: float) -> void:
	if !dead and !takingDmg:
		$detectionArea/CollisionShape2D.disabled = false
		if player_in_area:
			position += (player.position - position) /speed
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
	else:
		$detectionArea/CollisionShape2D.disabled = true
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body
		
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method("deal_damage"):
		take_damage(25)

func take_damage(dmg):
	heatlh-= dmg
	takingDmg =true
	$AnimatedSprite2D.play("damage")
	await get_tree().create_timer(0.5).timeout
	takingDmg =false
	if heatlh <=0 and !dead:
		killEnemy()

func killEnemy():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	queue_free()
	
		
