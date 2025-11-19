extends CharacterBody2D
var health
var speed = 100

@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

var melee = false
var chase = false
var ranged = false
var xDirection = 1
var yDirection = 0
var facing = "right"
var body
var direction = 0
@onready var player: CharacterBody2D = %Player
var projectile_original = preload("res://scenes/enemy_arrow.tscn") 
var maxtimer = 1
var timer = maxtimer


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D




func _ready():
	pass
func facing_direction():
	if abs(position.x-player.position.x) > abs(position.y-player.position.y):
		if position.x > player.position.x:
			facing = "left"
		else:
			facing = "right"
	else:
		if position.y < player.position.y: 
			facing = "down"
		else:
			facing = "up"

func _process(delta):
	facing_direction()
	update_animation()
	
	if ranged:
		timer -= delta
	if timer <0 and ranged == true:
		timer = maxtimer
		shoot()
	if melee:
		timer -= delta
	if timer <0 and melee == true:
		timer = maxtimer
		melee_hit()
	elif !ranged and !melee and chase:
		direction = position.direction_to(player.position)
		position +=direction*speed*delta
		print("chase")
	elif !ranged and !chase and melee:
		pass
	

func _on_melee_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		melee = true
		chase = false
	
func _on_melee_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		melee = false
		chase = true


func _on_chase_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true
		ranged = false 


func _on_chase_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false
		ranged = true


func _on_ranged_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		ranged = true
		chase = false
		shoot()
func _on_ranged_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		ranged = false
func shoot():
	
	var projectile_clone = projectile_original.instantiate()
	

	projectile_clone.global_position = position

	projectile_clone.set_direction(player.position)
	
	
	get_tree().get_root().add_child(projectile_clone)
func update_animation():
	if ranged == true:
		animation_player.play("crossbow_shoot_" + facing)
	elif chase == true:
		animation_player.play("crossbow_walk_" + facing)
	elif melee == true:
		animation_player.play("attack_" + facing)
	elif velocity.is_zero_approx():
		animation_player.play("crossbow_idle_" + facing)
func melee_hit():
	player.change_health(-5)
	pass
