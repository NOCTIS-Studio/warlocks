extends Area2D

@export var wait_time: float = 5.0
@export var shrink_time: float = 5.0
@export var shrink_rate: float = 0.05  # Rate at which the shape shrinks every 5 seconds
@export var minimum_scale: float = 0.1 # Minimum size before it stops shrinking
@export var damage_delay: float = 2.0
@onready var wait_timer = $WaitTimer
@onready var shrink_timer = $ShrinkTimer
@onready var collision_shape = $SafeZone
@onready var damage_timer = Timer.new()
@onready var outside_display = $"../OutsideDisplay"
var radius: float = 1151.0

@export var damage_amount: int = 10
var players_in_area: Dictionary = {}

func _ready() -> void:
	outside_display.material.set_shader_parameter("center", position)  # Set the center of the shader
	outside_display.material.set_shader_parameter("radius", radius)
	var size = outside_display.get_size()  # Size of the TextureRect
	outside_display.material.set_shader_parameter("screen_size", size)
	var texture = preload("res://assets/Texture/lava.png")
	outside_display.material.set_shader_parameter("outside_texture", texture)
	wait_timer.wait_time = wait_time
	shrink_timer.wait_time = shrink_time
	add_child(damage_timer)
	damage_timer.wait_time = damage_delay
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	wait_timer.start()

func _process(delta: float) -> void:
	pass


func _on_wait_timer_timeout() -> void:
	shrink_timer.start()


func _on_shrink_timer_timeout() -> void:
	if scale.x > minimum_scale and scale.y > minimum_scale:
		scale -= Vector2(shrink_rate, shrink_rate)
		radius = radius * scale.x  # Update the radius based on the scale
		outside_display.material.set_shader_parameter("radius", radius)
		var size = outside_display.get_size()  # Size of the TextureRect
		outside_display.material.set_shader_parameter("screen_size", size)
	else:
		shrink_timer.stop()  # Stop shrinking if it hits the minimum size

func _on_body_entered(body: Node2D) -> void:
	print("Body entered safe zone:", body.name)
	if body.is_in_group("player"):
		players_in_area[body] = true
		damage_timer.stop()


func _on_body_exited(body: Node2D) -> void:
	print("Body exited safe zone:", body.name)
	if body.is_in_group("player"):
		players_in_area[body] = false
		damage_timer.start()
		
func _on_damage_timer_timeout():
	print("take damage out of zone")
	for player in players_in_area.keys():
		if players_in_area[player] == false:  # If the player is outside the area
			player.take_damage(damage_amount)
