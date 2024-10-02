class_name MainMenu

extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button
@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button
@onready var options_menu: OptionsMenu = $Options_Menu

@onready var margin_container: MarginContainer = $MarginContainer

@onready var start_game = preload("res://scenes/game.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.

func _ready():
	handle_connecting_signals()


func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_game)

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true
	

func on_exit_pressed() -> void:
	get_tree().quit()

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	

func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
