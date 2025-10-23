extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var _animation_player: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D

var facing = "down"

func _ready() -> void:
	_animation_player.play("off")


func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "Player":
		
		if name == "Lever":
			if player.lever1:
				player.lever1=false
				_animation_player.play("off")
				
			else:
				player.lever1=true
				_animation_player.play("on")
				
		if name == "Lever2":
			if player.lever2:
				player.lever2=false
				_animation_player.play("off")
			else:
				player.lever2=true
				_animation_player.play("on")
		if name == "Lever3":
			if player.lever3:
				player.lever3=false
				_animation_player.play("off")
			else:
				player.lever3=true
				_animation_player.play("on")
		if name == "Lever4":
			if player.lever4:
				player.lever4=false
				_animation_player.play("off")
			else:
				player.lever4=true
				_animation_player.play("on")
	
func update_animation():
		pass
	
		
		
		
		
	


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
