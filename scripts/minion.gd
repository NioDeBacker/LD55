class_name Minion
extends CharacterBody2D


@export var SPEED: float = 50.0
@export var max_health: int = 30
@export var damage: int = 10
var current_health


var locked_enemy = null
var other_spotted_enemies

func _ready():
	set_as_top_level(true)
	current_health = max_health
	$AnimatedSprite2D.play("default")
	

func _physics_process(delta):
	if locked_enemy != null && global_position.distance_to(locked_enemy.global_position) > 16:
		var velocity = global_position.direction_to(locked_enemy.global_position)
		move_and_collide(velocity * SPEED * delta)
	else:  # Move in a random direction
		var random_angle = randf_range(0, 2 * PI)  # Random angle between 0 and 2*PI (360 degrees)
		var random_direction = Vector2(cos(random_angle), sin(random_angle))
		move_and_collide(random_direction * SPEED * delta)

func deal_damage(damage):
	# print("hier")
	current_health -= damage
	$HealthDisplay.update_healthbar(current_health)
	if current_health < 0:
		queue_free()
	
func hit():
	var direction = (locked_enemy.global_position - global_position).normalized()
	var target_angle = direction.angle()
	# Convert the angle from radians to degrees
	var target_rotation_degrees = rad_to_deg(target_angle)
	# Set the rotation of the CollisionShape2D to face towards the castle
	$AttackArea/CollisionShape2D.rotation_degrees = target_rotation_degrees
	$AttackArea.monitoring = true
	$AnimatedSprite2D.play("attack")
	
func end_of_hit():
	$AttackArea.monitoring = false
	$AnimatedSprite2D.play("default")

func _on_detection_area_body_entered(body):
	if locked_enemy == null && body is Enemy:
		locked_enemy = body
		locked_enemy.tree_exiting.connect(_on_Enemy_tree_exiting)

func _on_attack_area_body_entered(body):
	if body is Enemy:
		body.deal_damage(damage)
	
func _on_Enemy_tree_exiting():
	locked_enemy = null


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		end_of_hit()
		if locked_enemy != null:
			hit()
