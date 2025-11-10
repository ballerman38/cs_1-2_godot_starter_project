extends CharacterBody2D
var projectile_original = preload("res://scenes/enemy_projectile.tscn")
@export var offset : Vector2 = Vector2(0, -25)
var maxtimer = 2  
var timer = maxtimer
var in_range = false
var player
func _ready():
	
	pass

func _process(delta: float) -> void:
	if in_range:
		timer -= delta
	if timer <0:
		shoot()
		timer = maxtimer
	pass


	

	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = false
	pass # Replace with function body.
func shoot():
	var projectile_clone = projectile_original.instantiate()
	

	projectile_clone.global_position = position + offset
	

	projectile_clone.set_direction(player.position)
	
	
	get_tree().get_root().add_child(projectile_clone)

	
