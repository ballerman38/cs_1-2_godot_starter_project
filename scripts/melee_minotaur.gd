extends CharacterBody2D
var health
var speed = 100

var melee = false
var chase = false
var ranged = false
var xDirection = 1
var yDirection = 0
var facing = "down"
var body
var direction = 0
@onready var player: CharacterBody2D = %Player
var projectile_original = preload("res://scenes/enemy_arrow.tscn") 
var maxtimer = 1
var timer = maxtimer


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D




func _ready():
	pass


func _process(delta):
	if xDirection > 0:
		facing = "right"
	elif xDirection < 0:
		facing = "left"
	elif yDirection < 0: 
		facing = "up"
	elif yDirection > 0:
		facing = "down"
	
	if ranged:
		timer -= delta
	if timer <0 and ranged == true:
		timer = maxtimer
		shoot()
	
	elif !ranged and !melee and chase:
		direction = position.direction_to(player.position)
		position +=direction*speed*delta
		print("chase")
	elif !ranged and !chase and melee:
		print(" ")
	if abs(position.x - player.position.x) > abs(position.y - player.position.y):
		if position.x > player.position.x:
			facing = "right"
		elif position.x < player.position.x:
			facing = "left"
		if position.y > player.position.y:
			facing = "down"
		elif position.y < player.position.y:
			facing = "up"
func set_direction(_direction):
	direction = position.direction_to(_direction)
	if direction.x < 0:
		scale *= -1
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
