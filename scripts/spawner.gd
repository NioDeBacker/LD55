extends StaticBody2D

# Node refs
@onready var spawned_characters = $SpawnedCharacters
@onready var tilemap = get_tree().root.get_node("world/TileMap")
@onready var world = get_tree().root.get_node("world")

@export var spawnType: PackedScene

var rng = RandomNumberGenerator.new()

func _ready():
	$Sprite2D.play("default")

func spawn_character():
	var character = spawnType.instantiate()
	spawned_characters.add_child(character)
	return character

