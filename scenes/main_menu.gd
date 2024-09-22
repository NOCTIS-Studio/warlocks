class_name MainMenu

extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button
@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button
@onready var start_game = preload("res://scenes/game.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	handle_connecting_signals()


func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_game)

func on_options_pressed() -> void:
	print("LOAD OPTIONS MENU")

func on_exit_pressed() -> void:
	get_tree().quit()


func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	exit_button.button_down.connect(on_exit_pressed)
