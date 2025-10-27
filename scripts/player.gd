extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
var projectile_original = preload("res://scenes/projectile.tscn")
@onready var hit_box: Area2D = $Area2D
var lever1 = false
var lever2 = false
var lever3 = false
var lever4 = false
var enemy = null
var xSpeed = 300.0
var facing = "down"
var xDirection = 0
var ySpeed = 300.0
var yDirection = 0
var coins = 0
@export var offset : Vector2 = Vector2(0, -25)
var attacking = false
var max_attack_timer = 0.67
var attacktimer = max_attack_timer

# TODO: Add health system variables
var maxHealth = 10
var health = maxHealth
var attack_timer = 0.67
func _ready() -> void:
	pass

func _physics_process(_delta):
	# TODO: Get horizontal input (left/right keys)
	# Input.get_axis checks two keys and gives us a number:
	# - When LEFT is pressed: returns -1.0
	# - When RIGHT is pressed: returns 1.0  
	# - When NOTHING is pressed: returns 0.0
	xDirection = Input.get_axis("ui_left", "ui_right")
	
	# TODO: Get vertical input (up/down keys)  
	# Same idea, but for up and down movement
	yDirection = Input.get_axis("ui_up", "ui_down")
	
	# TODO: Set the player's velocity (how fast they're moving)
	# Godot's CharacterBody2D uses a velocity system
	#velocity is a vector, define it as a product of speed and direction
	velocity.x = xDirection * xSpeed
	velocity.y = yDirection * ySpeed
	
	# TODO: Update facing direction based on movement
	if xDirection > 0:
		facing = "right"
		hit_box.position = Vector2(30,0)
	elif xDirection < 0:
		facing = "left"
		hit_box.position = Vector2(-30,0)
	elif yDirection < 0:
		facing = "up"
		hit_box.position = Vector2(0,-30)
	elif yDirection > 0:
		facing = "down"
		hit_box.position = Vector2(0,30)
	if Input.is_action_just_pressed("ui_select"):
		shoot()
		
	if attacking == true:
		attack_timer -= _delta
	if attack_timer < 0:
		attacking = false
		attack_timer = max_attack_timer
	
	
	# call the animation function
	update_animation()
	if Input.is_action_just_pressed("ui_accept"):
		attacking = true
	
	# This is a special Godot function that makes the movement happen
	move_and_slide()

# TODO: Create animation function (add this outside of _physics_process)
func update_animation():
	if attacking == true:
		_animation_player.play("attack_" + facing)
	# TODO: Set the animation based on the facing direction
	elif velocity.is_zero_approx():
		_animation_player.play("idle_" + facing)
	# This combines "idle_" with whatever direction we're facing
		pass
	elif !velocity.is_zero_approx():
		#walking animation here
		_animation_player.play("walk_" + facing)
		pass
		
	
func attack():
	attacking = false
	pass

# TODO: Create health change function for interactions
func change_health(_amount:int):
		health += _amount
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth
		print("Health: ", health)

func change_coins(_amount:int):
	coins += _amount
	print("you have " +str(coins) +" coins")

func die():
	print("you died")
	
# TODO: Create shooting function
func shoot():
	# TODO: Create a new projectile instance
	var projectile_clone = projectile_original.instantiate()
	
	# TODO: Set projectile position to player position
	projectile_clone.global_position = position + offset
	
	# TODO: Set projectile direction using facing variable
	projectile_clone.set_direction(facing)
	
	# TODO: Add projectile to the game world
	get_tree().get_root().add_child(projectile_clone)

	pass

func process():
	if enemy !=null and attacking == true:
		enemy.queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy = body
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "enemy":
		enemy = null
	
	
	pass # Replace with function body.
