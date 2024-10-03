extends CharacterBody2D

signal player_fired_bullet(bullet, position, direction)

@export var Bullet: PackedScene
const SPEED = 100.0
var health = 200
var current_dir = "none"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var end_of_wand: Marker2D = $EndOfWand
@onready var wand_direction: Marker2D = $WandDirection
@onready var cooldown_1: Timer = $Cooldown1
@onready var cooldown_2: Timer = $Cooldown2

var can_spell1: bool = true
var can_spell2: bool = true

func _ready() -> void:
	animated_sprite_2d.play("front_idle")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("spell_1") and can_spell1:
		can_spell1 = false
		cooldown_1.start()
		spell.emit(end_of_wand.global_position, player_direction, "fireball")
	elif Input.is_action_pressed("spell_2") and can_spell2:
		can_spell2 = false
		cooldown_2.start()
		spell.emit(end_of_wand.global_position, player_direction, "frostbolt")
	player_movement(delta)



func player_movement(delta):
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		play_animation(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		play_animation(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		current_dir = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
	#look_at(get_global_mouse_position())

func play_animation(movement):
	var dir = current_dir
	var animation = animated_sprite_2d
	if dir == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("side_walk")
		else:
			animation.play("side_idle")
	elif dir == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("side_walk")
		else:
			animation.play("side_idle")
	elif dir == "down":
		if movement == 1:
			animation.play("front_walk")
		else:
			animation.play("front_idle")
	elif dir == "up":
		if movement == 1:
			animation.play("back_walk")
		else:
			animation.play("back_idle")
			
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		shoot()
		
func shoot():
	var bullet_instace = Bullet.instantiate()
	add_child(bullet_instace)
	bullet_instace.global_position = end_of_wand.global_position
	var target = get_global_mouse_position()
	var direction_to_mouse = end_of_wand.global_position.direction_to(target).normalized()
	bullet_instace.set_direction(direction_to_mouse)

#Function to detect players as enemies
func take_dmg_player(dmg: int):
	health -=dmg
	print("my life is : " + str(health) )

func take_damage(amount: int):
	print("received damage" + str(amount))


func _on_cooldown_1_timeout() -> void:
	can_spell1 = true


func _on_cooldown_2_timeout() -> void:
	can_spell2 = true
