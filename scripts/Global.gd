extends Node

signal enemy_hit
# Scene resources
@onready var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var score = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
