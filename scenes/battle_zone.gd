extends Area2D

@export var wait_time: float = 10.0
@export var shrink_time: float = 5.0
@export var shrink_rate: float = 0.05  # Rate at which the shape shrinks every 5 seconds
@export var minimum_scale: float = 0.1 # Minimum size before it stops shrinking
@export var damage_delay: float = 2.0
@onready var wait_timer = $WaitTimer
@onready var shrink_timer = $ShrinkTimer
@onready var collision_shape = $SafeZone
@onready var damage_timer = Timer.new()
@onready var lava_ground = $"../MapLevel/LavaGround"
@onready var base_ground = $"../MapLevel/BaseGround"
@onready var top_ground = $"../MapLevel/Topground"
@onready var shadow_ground = $"../MapLevel/Shadows"
@onready var second_level_ground = $"../MapLevel/GroundSecondLevel"
@onready var second_level_border = $"../MapLevel/BorderSecondLevel"
@onready var second_level_shadow = $"../MapLevel/ShadowsSecondLevel"
@onready var second_level_topground = $"../MapLevel/TopgroundSecondLevel"
@onready var safe_zone = $SafeZone
@onready var circle_shape = safe_zone.shape as CircleShape2D


@export var damage_amount: int = 10
var original_radius
var players_in_area: Dictionary = {}

func _ready() -> void:
	wait_timer.wait_time = wait_time
	shrink_timer.wait_time = shrink_time
	add_child(damage_timer)
	damage_timer.wait_time = damage_delay
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	original_radius = circle_shape.radius
	wait_timer.start()

	print("radius = ",circle_shape.radius)

func _process(delta: float) -> void:
	pass


func _on_wait_timer_timeout() -> void:
	shrink_timer.start()


func _on_shrink_timer_timeout() -> void:
	if scale.x > minimum_scale and scale.y > minimum_scale:
		scale -= Vector2(shrink_rate, shrink_rate)  # Shrink both dimensions
		collision_shape.scale = scale
		circle_shape.radius = circle_shape.radius * scale.x
		remove_tiles_outside_battlezone()
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
			
func remove_tiles_outside_battlezone():
	var position = global_position
	var area_size = (circle_shape.radius * scale.x ) / base_ground.rendering_quadrant_size
	print("Updated radius: ", circle_shape.radius)  # Print updated radius
	print("Updated scale: ", scale.x)
	
	var base_used_cells = base_ground.get_used_cells()
	var top_used_cells = top_ground.get_used_cells()
	var shadow_used_cells = shadow_ground.get_used_cells()
	var secondg_used_cells = second_level_ground.get_used_cells()
	var secondb_used_cells = second_level_border.get_used_cells()
	var secondt_used_cells = second_level_topground.get_used_cells()
	
	
	for cell in base_used_cells:
		if cell.distance_to(position) > area_size:
			base_ground.erase_cell(cell) 
	for cell in top_used_cells:
		if cell.distance_to(position) > area_size:
			top_ground.erase_cell(cell)
	for cell in shadow_used_cells:
		if cell.distance_to(position) > area_size:
			shadow_ground.erase_cell(cell)
	for cell in secondg_used_cells:
		if cell.distance_to(position) > area_size:
			second_level_ground.erase_cell(cell)
	for cell in secondb_used_cells:
		if cell.distance_to(position) > area_size:
			second_level_border.erase_cell(cell)
	for cell in secondt_used_cells:
		if cell.distance_to(position) > area_size:
			second_level_topground.erase_cell(cell)								
			
