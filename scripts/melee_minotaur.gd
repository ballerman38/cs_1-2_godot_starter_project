extends CharacterBody2D
var health
var speed = 200
var melee = false
var chase = false
var ranged = false
@onready var player: CharacterBody2D = %Player




func _ready():
	pass


func _process(delta):
	if melee == true:
		print("melee")
	elif !melee and chase: 
		print("chase")
	elif !melee and !chase and ranged:
		print("ranged")
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

func _on_ranged_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		ranged = false
