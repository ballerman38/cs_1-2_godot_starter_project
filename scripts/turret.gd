extends CharacterBody2D
var projectile_original = preload("res://scenes/enemy_projectile.tscn")
@export var offset : Vector2 = Vector2(0, -25)

func _ready():
	
	pass

func _process(delta: float) -> void:
	pass


	
func shoot(body):
	var projectile_clone = projectile_original.instantiate()
	

	projectile_clone.global_position = position + offset
	

	projectile_clone.set_direction(body.position)
	
	
	get_tree().get_root().add_child(projectile_clone)

	pass
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		shoot(body)
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
