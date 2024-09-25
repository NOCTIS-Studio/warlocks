extends CharacterBody2D


var speed = 45
var health = 100
var attackDmg = 5
var dead = false
var taking_dmg =false
var state
var dir : Vector2
var player
var spawn_position: Vector2  


func _ready() -> void:
	state= "patrol"
	spawn_position = position
	
func _physics_process(delta: float) -> void:
	if( spawn_position.distance_to(position) > 200 and state=="patrol"):
		state= "return"
	if !dead and !taking_dmg:
		$detectionArea/CollisionShape2D.disabled = false
		match state:
			"patrol":
				velocity += dir*speed*delta	
				move_and_slide()
				handle_animation()
			"chase":
				velocity = position.direction_to(player.position)*speed
				dir.x = abs(velocity.x)/ velocity.x
				move_and_slide()
				handle_animation()
			"return":
				if(spawn_position.distance_to(position)<5):
					state = "idle"
				velocity = position.direction_to(spawn_position)*speed
				dir.x = abs(velocity.x)/ velocity.x
				move_and_slide()
				handle_animation()
			"attack":
				_attack_player()
			"idle":
				_idle()
	else:
		$detectionArea/CollisionShape2D.disabled = true

func _attack_player():
	player.take_dmg_player()
	$AnimatedSprite2D.play("heavyAttack")
	await get_tree().create_timer(0.6).timeout


func _idle():
	$AnimatedSprite2D.play("idle")
	await get_tree().create_timer( choose([1 , 2, 3,4])).timeout
	state = "patrol"

func handle_animation():
	var animated_Sprite = $AnimatedSprite2D
	animated_Sprite.play("move")
	animated_Sprite.flip_h = (dir.x == -1)
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_dmg_player"):
		state = "chase"
		player = body
		
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("take_dmg_player"):
		state = "patrol"

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method("deal_damage") and !dead:
		take_damage(20)

func take_damage(dmg: int):
	health -= dmg
	taking_dmg = true
	$AnimatedSprite2D.play("damage")
	await get_tree().create_timer(0.3).timeout
	taking_dmg = false
	if health <= 0 and not dead:
		kill_enemy()
		
func kill_enemy():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	queue_free()
	
		
func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5 , 0.75 , 1, 1.4 ])
	if state =="patrol":
		dir=choose([Vector2.RIGHT, Vector2.LEFT,Vector2.UP, Vector2.DOWN])
	
func choose(array):
	array.shuffle()
	return array.front()

func _on_attak_range_body_entered(body: Node2D) -> void:
	if body.has_method("take_dmg_player"):
		print('hola')
		state = "attack"
		player = body

func _on_attak_range_body_exited(body: Node2D) -> void:
	if body.has_method("take_dmg_player"):
		state = "chase"


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.has_method("take_dmg_player"):
		print('hola')
		state = "attack"
		player = body

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.has_method("take_dmg_player"):
		state = "chase"
