extends Node2D

var mana = 150
var score = 0
@onready var manaBar = get_tree().root.get_node("world/HUD/VBoxContainer/HContainerMana/ManaBar")
@onready var scoreLabel = get_tree().root.get_node("world/HUD/VBoxContainer/HContainerScore/ScoreLabel")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.enemy_hit.connect(_on_Enemy_Hit) # Replace with function body.

func _on_Enemy_Hit():
	mana += 20
	manaBar.value = mana
	score += 1
	Global.score = score
	scoreLabel.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_minion_spawner_mana_used(mana_used):
	mana -= mana_used
	manaBar.value = mana # Replace with function body.


func _on_castle_game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn") # Replace with function body.


func _on_mana_counter_timeout():
	if mana < 150 + (10 * Global.score):

		mana += 10
		manaBar.value = mana # Replace with function body.


func _on_tree_exiting():
	Global.score = score # Replace with function body.
