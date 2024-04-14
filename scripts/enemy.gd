class_name Enemy
extends CharacterBody2D

@onready var castle = get_tree().root.get_node("world/castle")

const SPEED = 50.0

var max_health = 100
var current_health = 50
var damage = 10
var move = true
var locked_on_enemy = null

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	if castle == null:
		return
	var enemy_position = castle.global_position
	if locked_on_enemy != null:
		enemy_position = locked_on_enemy.global_position
	if global_position.distance_to(enemy_position) > 50.0:
		var velocity = global_position.direction_to(enemy_position)
		move_and_collide(velocity * SPEED * delta)
		
func hit():
	var enemy_position = null
	if locked_on_enemy != null:
		enemy_position = locked_on_enemy.global_position
	var direction = (enemy_position - global_position).normalized()
	var target_angle = direction.angle()
	# Convert the angle from radians to degrees
	var target_rotation_degrees = rad_to_deg(target_angle)
	# Set the rotation of the CollisionShape2D to face towards the castle
	$AttackArea/CollisionShape2D.rotation_degrees = target_rotation_degrees
	$AttackArea.monitoring = true
	$AttackTimer.start()
	
func end_of_hit():
	$AttackArea.monitoring = false
	$AnimatedSprite2D.play("default")

func _on_detection_area_body_entered(body):

	if body != self && body is Enemy:
		move = true
	
	if locked_on_enemy == null && (body.name == "castle" || body is Minion):
		locked_on_enemy = body
		locked_on_enemy.tree_exiting.connect(_on_Enemy_tree_exiting)
		hit()
	

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _on_attack_area_body_entered(body):
	if body.name == "castle" || body is Minion:
		print("hier", body.name)
		body.deal_damage(damage) # Replace with function body.

func deal_damage(damage):
	# print("hier")
	current_health -= damage
	$HealthDisplay.update_healthbar(current_health)
	if current_health < 0:
		Global.enemy_hit.emit()
		queue_free()

func _on_attack_timer_timeout():
	end_of_hit()
	if locked_on_enemy != null:
		hit()
		
func _on_Enemy_tree_exiting():

	locked_on_enemy = null
	if locked_on_enemy == castle:
		print("in enemy castle dood")
		castle = null
	var others = $DetectionArea.get_overlapping_bodies()
	for other in others:
		if other.name == "castle" || other is Minion:
			locked_on_enemy = other
	move = true

func _on_detection_area_body_exited(body):
	if body != self && body is Enemy:
		move = true # Replace with function body.

